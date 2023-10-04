Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF27B7C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjJDJuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjJDJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:50:53 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE4AB7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRr8O79q4KAm9LHhdQBv90pQcIyPcffgLsfMMGyOi4k=;
 b=FH20lKsZH6QTr6pyRv0FMN/56BJe34lYz+5/4UhAZ6yXyVrxTJz7o0yWcKlcNq1Vb+Fh4ZwUjnVCJ/yJoLUP+KNEGHmcr88t6RaV3P057SNVAN3UrjVG7282+tec+TyofemOWwQxgpH3IqX/ClZbKtk2K+SC1KFzIQ+086YlkOE=
Received: from DB8PR04CA0026.eurprd04.prod.outlook.com (2603:10a6:10:110::36)
 by AS4PR08MB7878.eurprd08.prod.outlook.com (2603:10a6:20b:51d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:50:40 +0000
Received: from DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::a5) by DB8PR04CA0026.outlook.office365.com
 (2603:10a6:10:110::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Wed, 4 Oct 2023 09:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT063.mail.protection.outlook.com (100.127.142.255) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.26 via Frontend Transport; Wed, 4 Oct 2023 09:50:40 +0000
Received: ("Tessian outbound 9aeaca65ec26:v211"); Wed, 04 Oct 2023 09:50:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f050de1b0f6484c5
X-CR-MTA-TID: 64aa7808
Received: from 4e75d1152161.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8F3C78CB-2E95-4351-AF4F-E170A67BE5D3.1;
        Wed, 04 Oct 2023 09:50:29 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4e75d1152161.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 04 Oct 2023 09:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGQrI93pfW4ULCCRQuBHPjvWAW4wbCQcqNNJdba0Eqa0Vmk4DlBTQsMX5xjzm+mGdO0KbtIXNnofXSkRLeK2sb9zE9wyti1A+cVMwORf6GSLSXUqTmXS+u/dNxxjaPwgB++RQXSCCNZQ/xZ8Uwnu/i99bmUUf8ZSO/rcMzVd1UVt2o/usvvbpCiZpkzSoMsErPvntQRqJdhEZajSPf9x80uPfvsep6UjX9ND9JV8KMeYlsR5zny32YPFvOG8xWL2AuzZ/dNRzgrISIo1bGxhepueQ+MivLwxtsOCERnz/xpzveDUfc7cV2GOwBlpTIUuNX+OAt5rvo6SORikpptzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRr8O79q4KAm9LHhdQBv90pQcIyPcffgLsfMMGyOi4k=;
 b=TIAWM0uMTgcQHLwEPBTRlOdGnWRD7ETRtg7YkTWZDwBQJ+ybFBoS9beyJvl3eww/k8emnVCCNnMiTEh11c3jrVv10vODQsb1FrFqoAnlYAEhE8XzFkPkDL5WzTJg97GLT4zw0svUoyTICWp392zugTPYXbt9Sq50+7NF11y778AY0KQqzb9AfTtjXX/I/35fFdrvaj3/NAedLeXyNsQ3e+fvI0x9sIpXJEYJnna9in06vXktGw0709WAm4DmhH4S+DDdjkHk+F7xffs8vpNkzsI+WiLmm30HTb/aSk1crwAUU8CVO+lO9zXovB+Q+b9HVyEDfzgFKZhE93CXJxtJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRr8O79q4KAm9LHhdQBv90pQcIyPcffgLsfMMGyOi4k=;
 b=FH20lKsZH6QTr6pyRv0FMN/56BJe34lYz+5/4UhAZ6yXyVrxTJz7o0yWcKlcNq1Vb+Fh4ZwUjnVCJ/yJoLUP+KNEGHmcr88t6RaV3P057SNVAN3UrjVG7282+tec+TyofemOWwQxgpH3IqX/ClZbKtk2K+SC1KFzIQ+086YlkOE=
Received: from DB9PR08MB6796.eurprd08.prod.outlook.com (2603:10a6:10:2ad::16)
 by PAWPR08MB10018.eurprd08.prod.outlook.com (2603:10a6:102:363::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 09:50:27 +0000
Received: from DB9PR08MB6796.eurprd08.prod.outlook.com
 ([fe80::38fa:73c3:8734:da10]) by DB9PR08MB6796.eurprd08.prod.outlook.com
 ([fe80::38fa:73c3:8734:da10%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 09:50:26 +0000
From:   Olivier Deprez <Olivier.Deprez@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Bonnici <Marc.Bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Thread-Topic: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Thread-Index: AQHZ8uYfXUltWHUNdUaSfjUxLh+2BLA5X9YAgAAKSRg=
Date:   Wed, 4 Oct 2023 09:50:26 +0000
Message-ID: <DB9PR08MB67968986584B6EAC87B20C439BCBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com>
 <20231004091154.GB1091193@rayden>
In-Reply-To: <20231004091154.GB1091193@rayden>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DB9PR08MB6796:EE_|PAWPR08MB10018:EE_|DBAEUR03FT063:EE_|AS4PR08MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6128fd-b2bc-4ef5-7961-08dbc4bf5e9a
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xg68xhL0qcSz1oHb6Fw7YBgNT7a/mHzOYTX1V+74ZTMWwezxe4hapId6Z6y2r++2CEZsNmYnkBEwJmTIdiZGvp9JCiSe1an6Xb+iEdno3cKkA/VKz41N98pZJyt7l61Zj6CWDuq7P7B2nFaa4oKoz8t5EOcfiMr8CVHqw99/YLpkQPbi6wtZQ0keDgo6aFKaedM9yLhF5LnBXaQXGJMzqb7Efag+ajgiBhVq6MWJhp4MbYj47dPZkbPWeRf7rzLqBZI/OYcvt2p92C99i1UmRvxOIocXZDI0dbbRW5Aq7V7g6R2HFHBhrTqyvv0n/yXSOfsq4nzgwMWcDWAEubZF+sDTIPoZIIQ8WNkuZITm0I1jizETMrsLPJ55VgJBZgkEFcrzd6riGTon65xMaSb4dEcAI2DYaA4chwB0o5PIowB06gKdjU1CNhJnuAQymFEu9l+ht8JESazyykN8RIxUY5I7Cvf3fJoNlKLY8tpywhICTEfQQ4kFmVhP+DePsqm++sPQE16CoSy+CpjObPari8tvJYraep08bclU7V6iuRSfb1u4cDxh6mhU9aQDoR9d75JJ4OT60lAFsAehxmlZaDcs7twHDCXf8RoGHIDdYyQ16uIccscYHwnYbjP85S1r
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6796.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(33656002)(83380400001)(52536014)(86362001)(8676002)(5660300002)(8936002)(53546011)(26005)(71200400001)(4326008)(9686003)(6506007)(7696005)(122000001)(64756008)(55016003)(38100700002)(38070700005)(478600001)(2906002)(66946007)(110136005)(76116006)(316002)(91956017)(66446008)(66476007)(6636002)(54906003)(41300700001)(15650500001)(66556008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10018
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b35215cb-2812-4e8f-bd1a-08dbc4bf565d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLvG+JSlDmfhUxHRpZiYIVtirT5cPoGFNiIJV8njP1X4vMXS2VFZK0TiXnacKGyB3pmtbdahVLRWvrEfTPuPdH8iafQCgXzSnqvFijDDIwAN+KyKF4HQVAukzqO17ouVL0vWiWW7RS7Ly+I5DFH5KLI40XqzeuFz40h6rfkrAlgEkAdOTieoTGqrqckBUIzq49zdCduY7t9wTWiGVtPyH5QCDa0h4T2FGm/W08/0uj2aeDXiI7mkXl16/cmqWoUPoctSR/hu2EDPdhshdhc5vsmJVWr/KlTapmBOCgIro4V3NCqnjmm0U+qBrn4onQo6zZhGxd6/BFgXXn8vGDkqwRG2bh1TYxbCtTxBmgXh/b4h9j6tbdHXu2ipMKhaFf+uoNt5Zd/wVbo64uX1NCOqy3o0xcDokqyF5l/IpSBZ1nYOOAHtAKOJF1KKAqHjaTFTF00x+saNUOCbpA2V1T7pkNXo2ltr4obqy68XWp+EaY9qoPkJwVvB1HyciwoUNpOeSvykJQxGwObTgDcQSXkbD5g3JSMeXefcMCkEEJ9jA2UJE3thVsgkFT7jjpLIMcw4l6m97l4M8Kc7JgPfa3dIDvUHMRVx6ItVBptqStphdzVrTh1T/L8ruNBkE9j5bOzaW0mR7OCNFcxLpJp0fpfOZ9HhsM9Bt8SUAg+Hrt0LCPAtn+qnl/1knM1w2EoekKHrKOXqL3AiGBu1uzWvLBMS79nACir/evOJW0Qw2t/Kq+yyjK8f4xObn4wjUMWPcjah
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(55016003)(40480700001)(53546011)(478600001)(7696005)(6506007)(47076005)(336012)(36860700001)(356005)(86362001)(33656002)(82740400003)(81166007)(2906002)(83380400001)(26005)(9686003)(15650500001)(6636002)(4326008)(54906003)(41300700001)(70586007)(5660300002)(110136005)(316002)(70206006)(8936002)(8676002)(52536014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:50:40.8036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6128fd-b2bc-4ef5-7961-08dbc4bf5e9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7878
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,=0A=
=0A=
> dst_id and drv_info->vm_id should be swapped.=0A=
=0A=
I'm curious about this because swapping like this actually makes hafnium fa=
il. Need to check from the spec.=0A=
=0A=
Regards,=0A=
Olivier.=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: Jens Wiklander <jens.wiklander@linaro.org>=0A=
Sent: 04 October 2023 11:11=0A=
To: Sudeep Holla=0A=
Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Mar=
c Bonnici; Coboy Chen; Lorenzo Pieralisi; Olivier Deprez=0A=
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification=
 bind and unbind interface=0A=
=0A=
On Fri, Sep 29, 2023 at 04:02:52PM +0100, Sudeep Holla wrote:=0A=
> A receiver endpoint must bind a notification to any sender endpoint=0A=
> before the latter can signal the notification to the former. The receiver=
=0A=
> assigns one or more doorbells to a specific sender. Only the sender can=
=0A=
> ring these doorbells.=0A=
>=0A=
> A receiver uses the FFA_NOTIFICATION_BIND interface to bind one or more=
=0A=
> notifications to the sender. A receiver un-binds a notification from a=0A=
> sender endpoint to stop the notification from being signaled. It uses=0A=
> the FFA_NOTIFICATION_UNBIND interface to do this.=0A=
>=0A=
> Allow the FF-A driver to be able to bind and unbind a given notification=
=0A=
> ID to a specific partition ID. This will be used to register and=0A=
> unregister notification callbacks from the FF-A client drivers.=0A=
>=0A=
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>=0A=
> ---=0A=
>  drivers/firmware/arm_ffa/driver.c | 29 +++++++++++++++++++++++++++++=0A=
>  1 file changed, 29 insertions(+)=0A=
>=0A=
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa=
/driver.c=0A=
> index efa4e7fb15e3..26bf9c4e3b5f 100644=0A=
> --- a/drivers/firmware/arm_ffa/driver.c=0A=
> +++ b/drivers/firmware/arm_ffa/driver.c=0A=
> @@ -587,6 +587,35 @@ static int ffa_notification_bitmap_destroy(void)=0A=
>       return 0;=0A=
>  }=0A=
>=0A=
> +#define NOTIFICATION_LOW_MASK                GENMASK(31, 0)=0A=
> +#define NOTIFICATION_HIGH_MASK               GENMASK(63, 32)=0A=
> +#define NOTIFICATION_BITMAP_HIGH(x)  \=0A=
> +             ((u32)(FIELD_GET(NOTIFICATION_HIGH_MASK, (x))))=0A=
> +#define NOTIFICATION_BITMAP_LOW(x)   \=0A=
> +             ((u32)(FIELD_GET(NOTIFICATION_LOW_MASK, (x))))=0A=
> +=0A=
> +static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,=0A=
> +                                     u32 flags, bool is_bind)=0A=
> +{=0A=
> +     ffa_value_t ret;=0A=
> +     u32 func, src_dst_ids =3D PACK_TARGET_INFO(dst_id, drv_info->vm_id)=
;=0A=
=0A=
dst_id and drv_info->vm_id should be swapped.=0A=
=0A=
Thanks,=0A=
Jens=0A=
=0A=
> +=0A=
> +     func =3D is_bind ? FFA_NOTIFICATION_BIND : FFA_NOTIFICATION_UNBIND;=
=0A=
> +=0A=
> +     invoke_ffa_fn((ffa_value_t){=0A=
> +               .a0 =3D func, .a1 =3D src_dst_ids, .a2 =3D flags,=0A=
> +               .a3 =3D NOTIFICATION_BITMAP_LOW(bitmap),=0A=
> +               .a4 =3D NOTIFICATION_BITMAP_HIGH(bitmap),=0A=
> +               }, &ret);=0A=
> +=0A=
> +     if (ret.a0 =3D=3D FFA_ERROR)=0A=
> +             return ffa_to_linux_errno((int)ret.a2);=0A=
> +     else if (ret.a0 !=3D FFA_SUCCESS)=0A=
> +             return -EINVAL;=0A=
> +=0A=
> +     return 0;=0A=
> +}=0A=
> +=0A=
>  static void ffa_set_up_mem_ops_native_flag(void)=0A=
>  {=0A=
>       if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL, NULL) ||=0A=
>=0A=
> --=0A=
> 2.42.0=0A=
>=0A=
