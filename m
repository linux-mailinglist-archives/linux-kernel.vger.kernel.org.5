Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40297E369E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjKGI3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjKGI3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:29:09 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2DDF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:29:05 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231107082902epoutp0483517286d6bfdd230fb8cf90fd1296d6~VSfL51TeU2255722557epoutp04D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:29:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231107082902epoutp0483517286d6bfdd230fb8cf90fd1296d6~VSfL51TeU2255722557epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699345742;
        bh=7B3ukQc7U62HnWYF57yCt5C7m/x0mmygbavz01LVHFY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hCMjZs8xgMag/1fH/OlM2SnoebL9aCw63lIj9HvLEltlhTBAVwopwMAeH47kAjcM+
         0YmMo/bQHBcZm3MK5DiK7olq5JTpKIK5OQiKNA2tFrVntGkFw4Zq4I0B49E4dqPUdO
         vjZO51fc/5IwXrJ1BtN8ndS5jr5sgMAh2RrtTH+8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231107082901epcas5p4c420b66224be797409533a7979cce1ec~VSfLW01P22141621416epcas5p4x;
        Tue,  7 Nov 2023 08:29:01 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-6b-6549f54d227f
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.22.10009.D45F9456; Tue,  7 Nov 2023 17:29:01 +0900 (KST)
Mime-Version: 1.0
Subject: Re[2]: [PATCH] input: gpio-keys - optimize wakeup sequence.
Reply-To: abhi1.singh@samsung.com
Sender: Abhishek Kumar Singh <abhi1.singh@samsung.com>
From:   Abhishek Kumar Singh <abhi1.singh@samsung.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SRI-N IT Security <sri-n.itsec@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZT2_XI-6D24gjbrO@google.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231107082901epcms5p80c830aecfe50bfb12b661defad701149@epcms5p8>
Date:   Tue, 07 Nov 2023 13:59:01 +0530
X-CMS-MailID: 20231107082901epcms5p80c830aecfe50bfb12b661defad701149
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7bCmuq7vV89Ug8lTVC0OL3rBaHHz0zdW
        i8u75rBZ/N+zg93ixJ9NzA6sHjtn3WX32LSqk82jb8sqRo/Pm+QCWKK4bFJSczLLUov07RK4
        Mr40zmUquGlecbzpDVsD40qDLkZODgkBE4mvLyazdzFycQgJ7GaUWHiska2LkYODV0BQ4u8O
        YZAaYQEXibYf51lAbCEBRYlFczqYIeJmEpvvvmMEKWcDmrNiOw9IWETAWuLAvg42kJHMAlcY
        JZqvXmCC2MUrMaP9KQuELS2xfflWRhCbU0BL4s7156wQcVGJm6vfssPY74/NZ4SwRSRa751l
        hrAFJR783M0IM+f7gVtsEHa9xKnvE1hAFksI9DBKzJv7CWqZucSZXz1gNq+Ar8TyvVvAGlgE
        VCWuXTwLtcxF4tPqHjCbWUBbYtnC18wgjzELaEqs36UPEeaT6P39BO6XHfNgbFWJ/Wf/McPc
        s2PSKqiRHhL/nh5lg4TtZUaJxW+uMk1glJ+FCN5ZSLbNQti2gJF5FaNkakFxbnpqsWmBUV5q
        uV5xYm5xaV66XnJ+7iZGcMrQ8trB+PDBB71DjEwcjIcYJTiYlUR4/9p7pArxpiRWVqUW5ccX
        leakFh9ilOZgURLnfd06N0VIID2xJDU7NbUgtQgmy8TBKdXAVOzSvGct+67Fm3ectLR437tz
        zxkWga/+QiwxFx4EfAmXvXjCfLuvwE+9WtEqyV96i11lzz05YsHqaujyzCDw4LQjmn4VL632
        H/JOu/H+v9Dm+crp+vzNuhJKRqsP7mCLerzi2McJZfNfGaft+eH96VTZimiRZwfTm/ua5JbO
        kmboKjv7Z+9cTf2PG18JKV7SZrF6Oq35Z5Ji+87DzLxn814tmV7GtmehS8Jr6473S+eEf+ri
        ucOT9+JStWlV8nX91gOhtmvCdddMnaixT+nLa8YbG80qsmYfPHxvnVPau1WPdKusInynLttz
        VI5/+5SNtivs09ifFDzUCQhpjLj+T8dRJIKD98Ljvn0NB15JNiqxFGckGmoxFxUnAgCFysH/
        iAMAAA==
X-CMS-RootMailID: 20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93
References: <ZT2_XI-6D24gjbrO@google.com>
        <899376598.3134980.1698299600677@mail-kr5-0.mail-kr5.knoxportal-kr-prod-blue.svc.cluster.local>
        <CGME20231017103415epcms5p2f8f5b28a8f5d71055622b82f71b0fc93@epcms5p8>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Dmitry,=20

Greetings=21=21=21

Thank you so much for your response.

I checked in detailed again and observed the below points, please help to r=
eview=20
and approve it.



There is ISR =22gpio_keys_gpio_isr=22 which is called when the key state is=
 1 i.e.=20
key pressed.
Therefore modified code will not impact on the existing driver code.

//For key pressed event:
<3>=5B  549.180072=5D I=5B0:      swapper/0:    0=5D gpio_keys_gpio_isr
<3>=5B  549.196126=5D  =5B1:    kworker/1:1:   78=5D gpio_keys_gpio_work_fu=
nc
<3>=5B  549.196198=5D  =5B1:    kworker/1:1:   78=5D gpio-keys soc:gpio_key=
s: gpio_keys_gpio_report_event key =3D 115, value =3D 1



Performance:

I have calculated the differece between entry & exit time=20
with modified and without modified code and observed that=20
0.3ms extra computation time in current scenario in each entry/exit time.

Because below APIs will not be called in every resume functions:

1. static void gpio_keys_report_state(struct gpio_keys_drvdata *ddata)
2. static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
3. gpiod_get_value_cansleep(bdata->gpiod);
4. input_event(input, type, *bdata->code, state);
5. input_sync(input)

So we can save 0.3ms computation time, resume operations will faster and sa=
ve battery as well.



With changes:

Line   311960: 07-18 16:50:09.359  root     0     0 I =5B0:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state exit 2023-07-18 11:20:37.573207725 UTC
Line   312626: 07-18 16:50:42.123  root     0     0 I =5B0:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state enrty 2023-07-18 11:22:20.503579404 UTC
Line   312627: 07-18 16:50:42.123  root     0     0 I =5B0:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state exit 2023-07-18 11:22:20.503656644 UTC
Line   313301: 07-18 16:52:24.182  root     0     0 I =5B0:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state enrty 2023-07-18 11:22:33.865626325 UTC
Line   313302: 07-18 16:52:24.182  root     0     0 I =5B0:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state exit 2023-07-18 11:22:33.865724502 UTC
Line   313572: 07-18 16:52:35.111  root     0     0 I =5B1:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state enrty 2023-07-18 11:22:37.678468979 UTC
Line   313573: 07-18 16:52:35.111  root     0     0 I =5B1:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state exit 2023-07-18 11:22:37.678566167 UTC
Line   314209: 07-18 16:52:43.598  root     0     0 I =5B0:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state enrty 2023-07-18 11:23:05.925340634 UTC
Line   314210: 07-18 16:52:43.598  root     0     0 I =5B0:   Binder:699_1:=
20972=5D PM: gpio_keys_report_state exit 2023-07-18 11:23:05.925439384 UTC


Without changes:

Line   372095: 07-18 16:10:24.250  root     0     0 I =5B1:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state exit 2023-07-18 10:43:38.592548979 UTC
Line   372344: 07-18 16:13:45.439  root     0     0 I =5B0:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state enrty 2023-07-18 10:44:11.589164226 UTC
Line   372346: 07-18 16:13:45.439  root     0     0 I =5B0:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state exit 2023-07-18 10:44:11.589514955 UTC
Line   372573: 07-18 16:14:13.414  root     0     0 I =5B0:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state enrty 2023-07-18 10:44:22.606227138 UTC
Line   372575: 07-18 16:14:13.414  root     0     0 I =5B0:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state exit 2023-07-18 10:44:22.606490107 UTC
Line   372944: 07-18 16:14:26.732  root     0     0 I =5B1:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state enrty 2023-07-18 10:44:29.024121927 UTC
Line   372946: 07-18 16:14:26.732  root     0     0 I =5B1:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state exit 2023-07-18 10:44:29.024528958 UTC
Line   373181: 07-18 16:14:30.790  root     0     0 I =5B0:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state enrty 2023-07-18 10:44:30.904866770 UTC
Line   373183: 07-18 16:14:30.790  root     0     0 I =5B0:   Binder:702_2:=
18137=5D PM: gpio_keys_report_state exit 2023-07-18 10:44:30.905126353 UTC




Thanks and Regards,
Abhishek Kumar Singh
Sr. Chief Engineer, Samsung Electronics, Noida-India


=C2=A0=0D=0A---------=C2=A0Original=20Message=C2=A0---------=0D=0ASender=C2=
=A0:=20dmitry.torokhov=40gmail.com=20<dmitry.torokhov=40gmail.com>=0D=0ADat=
e=C2=A0=20=C2=A0:=202023-10-29=2007:42=20(GMT+5:30)=0D=0ATitle=C2=A0=20:=20=
Re:=20=5BPATCH=5D=20input:=20gpio-keys=20-=20optimize=20wakeup=20sequence.=
=0D=0ATo=20:=C2=A0Abhishek=20Kumar=20Singh<abhi1.singh=40samsung.com>=0D=0A=
CC=20:=C2=A0robh=40kernel.org<robh=40kernel.org>,=20linux-input=40vger.kern=
el.org<linux-input=40vger.kernel.org>,=20linux-kernel=40vger.kernel.org<lin=
ux-kernel=40vger.kernel.org>,=20SRI-N=20IT=20Security<sri-n.itsec=40samsung=
.com>=0D=0A=C2=A0=0D=0AHi=20Abhishek,=0D=0A=0D=0AOn=20Thu,=20Oct=2026,=2020=
23=20at=2011:23:20AM=20+0530,=20Abhishek=20Kumar=20Singh=20wrote:=0D=0A>=20=
Dear=20Mr.=20Dmitry,=0D=0A>=20Greetings=21=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A>=
=20The=20patch=20removes=20unused=20many=20APIs=20call=20chain=20for=20ever=
y=20suspend/resume=20of=20the=20device=C2=A0=0D=0A>=20if=20no=20key=20press=
=20event=20triggered.=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A>=20There=20is=20a=20c=
all=20back=20function=20gpio_keys_resume()=20called=20for=0D=0A>=20every=20=
suspend/resume=20of=20the=20device.=20and=20whenever=20this=20function=20ca=
lled,=20it=20is=0D=0A>=20reading=20the=20status=20of=20the=20key.=20And=20g=
pio_keys_resume()=20API=20further=20calls=20the=0D=0A>=20below=20chain=20of=
=20API=20irrespective=20of=20key=20press=20event=0D=0A>=C2=A0=0D=0A>=C2=A0=
=0D=0A>=20APIs=20call=20chain:=0D=0A>=20static=20void=20gpio_keys_report_st=
ate(struct=20gpio_keys_drvdata=20*ddata)=0D=0A>=20static=20void=20gpio_keys=
_gpio_report_event(struct=20gpio_button_data=20*bdata)=0D=0A>=20gpiod_get_v=
alue_cansleep(bdata->gpiod);=0D=0A>=20input_event(input,=20type,=20*bdata->=
code,=20state);=0D=0A>=20input_sync(input);=0D=0A>=C2=A0=0D=0A>=C2=A0=0D=0A=
>=20The=20patch=20avoid=20the=20above=20APIs=20call=20chain=20if=20there=20=
is=20no=20key=20press=20event=20triggered.=0D=0A>=20It=20will=20save=20the=
=20device=20computational=20resources,=20power=20resources=20and=20optimize=
=20the=20suspend/resume=20time=0D=0A=0D=0AUnfortunately=20it=20also=20break=
s=20the=20driver=20as=20button->value=20does=20not=20hold=0D=0Athe=20curren=
t=20state=20of=20the=20GPIO=20but=20rather=20set=20one=20via=20device=20tre=
e=20so=20that=0D=0Athe=20driver=20can=20use=20that=20value=20when=20sending=
=20EV_ABS=20events.=20So=20with=0D=0Atypical=20GPIO-backed=20keys=20or=20bu=
ttons=20you=20change=20results=20in=20no=20events=0D=0Areported=20on=20resu=
me.=0D=0A=0D=0AI=20also=20wonder=20what=20kind=20of=20measurements=20you=20=
did=20on=20improvements=20to=0D=0Asuspend/resume=20time=20with=20your=20cha=
nge.=0D=0A=0D=0AThanks.=0D=0A=0D=0A--=C2=A0=0D=0ADmitry=0D=0A=0D=0A=C2=A0=
=0D=0AThanks=20and=20Regards,=0D=0A=C2=A0=C2=A0
