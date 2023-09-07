Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9019797D51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjIGUR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIGUR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:17:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AC7E47;
        Thu,  7 Sep 2023 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694117858; x=1694722658; i=s.l-h@gmx.de;
 bh=002B7dtZveSvlXJvRyiiPXH+/aT92UP3mkiQYUkXQM8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=e54jbTvM2qHuO3xnUpWTomxXjkF388WaQQlzWoc9p5VG/4RXH2pIfgFFYtOtqUKXsnXHlie
 J56h4LgA5XqxqaM9HxvGj6u7Ivpimx7AVuj/yTYajV2Ij0281/ee3HFveqShwkrIhCCUoql1x
 l34xMIQeaL5LfWxekicWziXD4NGYbZOkxpcarXJhh38CZuPHp2tbomnorbtR2GhsVbkn540uD
 CSqMCeV8YyhR6qGnfMEp/FY6/53SiJtCz2DPkvsOZCPXuEmnplTPZCONWV18DjX6IqEp1CDQQ
 8Osi8kchS6ARhoMrsQ953h5fhl2MNdOENxtQNuSnUrgP/wI71kPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.85.155]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1pioqW2iby-00vvPZ; Thu, 07
 Sep 2023 22:17:38 +0200
Date:   Thu, 7 Sep 2023 22:17:37 +0200
From:   Stefan Lippers-Hollmann <s.l-h@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.5 11/34] modules: only allow symbol_get of
 EXPORT_SYMBOL_GPL modules
Message-ID: <20230907221737.07f12f38@mir>
In-Reply-To: <2023090719-virtuous-snowflake-d015@gregkh>
References: <20230904182948.594404081@linuxfoundation.org>
        <20230904182949.104100132@linuxfoundation.org>
        <20230907084135.02d97441@mir>
        <2023090719-virtuous-snowflake-d015@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5l0rRcHjKVrENhDDVG7Fo6csXBgBkvbBgyKszA9ytvhEqYT3688
 3pyAKjm3iYbTmogNCs3DP5o+PBfLTavzkh4N/NWjmLbrKtXx8+yEgGLuXqKN8BXUkHcM6Mt
 d33EuMqhzdwTtkrrxeOsG1P0Y4SphJ/uCS3AdEMZWnfYW/o6HlBpRDR41Ys2SZ5SoyCyJqM
 wVNsfPqGPJTpceEVKo/IA==
UI-OutboundReport: notjunk:1;M01:P0:BJt2rC+ytNw=;aV8+ackWeOtXmaf52QYaKx23goF
 pgb84wNPe3AMC+SuOxPFw4Sztt8m6hmeMscvNjMyYhygjYILe/8fzd2EnPi81mtkckQEqUK8d
 8d+Z9zrU7PbH5KWxFfE0gcymAPeBoJMwXKAvAEfPoAq7YmC1ehgiyMIwqF/7Ob92C7b0Utjbe
 j9dW6qyS4vhAfaWew3xh9C0XaC5XcyRkEf5e10a1cTg8UoH2TBbynscLthJgdGmRO4PijeQ9q
 d/bDc5PHyLWcHwISCy7vEImJvR85IGoyKTnEUjcjpDnLSG2dNmOFc1vabIUXeGv3/ZDne1AWN
 slgydAmromFjqtAv6DKwTKUHZX9Im3fbyOkZxhTfq53EnKxZJukgAtcfYfvWQP6GvTAqOK0Mj
 h6cSEH2wAzcLtENNXO3GI/40CyyU1aHfuN0V8G2gvLSZlgukLMyn6U+I4og8uhIMKvm5zNejM
 OPX4tX6X1A3T77jYz29Q6McijgRM2RZMgCiqGVRbCsW06mH8gdn7Mwk1rUEcuiqD7cQIuFjNk
 VOG3drzyXoj9KIUA8aoD/ZsuCxE71t05qpCijYsYRcXOTZHPLrOYGNtt60F4kO0iDWFkCnoiZ
 AI5mmPC2hiCCM6/fKeWhQjE0EKYKqx7hRlopGdJ29CW0UP1zRCR7+7CVQxUXJyblO8u7Crw8A
 LE+c5AiKEynpsnMY7tTLc/NjlFB1Eu2WNgsuqx1XDg72MnSeQoftUapY97WokWBpHyKM5Gqj3
 wsN2tfZoEXvdE+Rvy7q6X5rv2GFgY5tePU2xBH3zKVh9YW2mKqcU08Dq3cVyMi5ywwhMbIBGJ
 /To7/JECRlv+UC+63wMY7cjIuilX9fEVOIP+EivVl9A0L4go0vw6XKaYA4fXzxmOOzwct5wR2
 Eb1fTDqrORRm17SAoa4PUH0ZQXqsocv89ks7FJLABD+/ZO9xYukUZ+irNuReG/mJAzaLuN2YJ
 OtwLfWcw2/1d2h8m0BDU4BRjgtU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023-09-07, Greg Kroah-Hartman wrote:
> On Thu, Sep 07, 2023 at 08:41:35AM +0200, Stefan Lippers-Hollmann wrote:
> > On 2023-09-04, Greg Kroah-Hartman wrote:
> > > 6.5-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Christoph Hellwig <hch@lst.de>
> > >
> > > commit 9011e49d54dcc7653ebb8a1e05b5badb5ecfa9f9 upstream.
> > >
> > > It has recently come to my attention that nvidia is circumventing th=
e
> > > protection added in 262e6ae7081d ("modules: inherit
> > > TAINT_PROPRIETARY_MODULE") by importing exports from their proprieta=
ry
> > > modules into an allegedly GPL licensed module and then rexporting th=
em.
> > >
> > > Given that symbol_get was only ever intended for tightly cooperating
> > > modules using very internal symbols it is logical to restrict it to
> > > being used on EXPORT_SYMBOL_GPL and prevent nvidia from costly DMCA
> > > Circumvention of Access Controls law suites.
> > >
> > > All symbols except for four used through symbol_get were already exp=
orted
> > > as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over=
 in
> > > the preparation patches.
> >
> > This patch, as part of v6.5.2, breaks the in-kernel ds3000 module
> > (for a TeVii s480 v2 DVB-S2 card, which is a PCIe card attaching two
> > onboard TeVii s660 cards via an onboard USB2 controller (MCS9990),
> > https://www.linuxtv.org/wiki/index.php/TeVii_S480) from loading.
>
> This is also broken in Linus's tree, right?

Yes, HEAD as of 6.5.0-12145-g4a0fc73da97e is affected just as well.

> > [    2.896589] dvbdev: dvb_create_media_entity: media entity 'dvb-demu=
x' registered.
> > [    2.901085] failing symbol_get of non-GPLONLY symbol ds3000_attach.
> > [    2.901089] DVB: Unable to find symbol ds3000_attach()
>
> This is odd, where is that call coming from?  I don't see any call to
> symbol_get in the dvb code, where is this happening?
>
> Anyway, does the patch below fix this?

That change alone only moves the issue down to ts2020_attach().

$ dmesg | grep -i -e dvb -e gpl -e symbol
[    1.464876] usb 3-1: Product: DVBS2BOX
[    1.482143] usb 5-1: Product: DVBS2BOX
[    3.692647] dvb-usb: found a 'TeVii S660 USB' in cold state, will try t=
o load a firmware
[    3.692951] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    3.860571] dvb-usb: found a 'TeVii S660 USB' in warm state.
[    3.860615] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    3.860944] dvbdev: DVB: registering new adapter (TeVii S660 USB)
[    4.097144] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
[    4.097272] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    4.111792] failing symbol_get of non-GPLONLY symbol ts2020_attach.
[    4.111795] DVB: Unable to find symbol ts2020_attach()
[    4.112759] usb 3-1: DVB: registering adapter 0 frontend 0 (Montage Tec=
hnology DS3000)...
[    4.112764] dvbdev: dvb_create_media_entity: media entity 'Montage Tech=
nology DS3000' registered.
[    4.138938] dvb-usb: schedule remote query interval to 150 msecs.
[    4.138942] dvb-usb: TeVii S660 USB successfully initialized and connec=
ted.
[    4.138988] dvb-usb: found a 'TeVii S660 USB' in cold state, will try t=
o load a firmware
[    4.139016] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    4.292614] dvb-usb: found a 'TeVii S660 USB' in warm state.
[    4.292679] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    4.293075] dvbdev: DVB: registering new adapter (TeVii S660 USB)
[    4.538876] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
[    4.539113] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    4.543738] failing symbol_get of non-GPLONLY symbol ts2020_attach.
[    4.546349] failing symbol_get of non-GPLONLY symbol ts2020_attach.
[    4.546354] DVB: Unable to find symbol ts2020_attach()
[    4.548643] usb 5-1: DVB: registering adapter 1 frontend 0 (Montage Tec=
hnology DS3000)...
[    4.548650] dvbdev: dvb_create_media_entity: media entity 'Montage Tech=
nology DS3000' registered.
[    4.549970] dvb-usb: schedule remote query interval to 150 msecs.
[    4.549973] dvb-usb: TeVii S660 USB successfully initialized and connec=
ted.
[    7.830408] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-=
fe-ds3000.fw)...
[    8.367600] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-=
fe-ds3000.fw)...

Extending this to approach to ts2020_attach() does fix the problem
for me. Searching the web for "failing symbol_get of non-GPLONLY
symbol" suggests that there might be further instances within the
DVB subsystem https://syzkaller.appspot.com/x/log.txt?x=3D11faa1eda80000
(this was merely gathered by a passive web search, I have no contact
to the poster or any further information about it).

[ now fully functional with EXPORT_SYMBOL_GPL(ds3000_attach) and
  EXPORT_SYMBOL_GPL(ts2020_attach) ]

$ dmesg | grep -i -e dvb -e gpl -e symbol -e taint
[    1.499064] usb 3-1: Product: DVBS2BOX
[    1.505760] usb 4-1: Product: DVBS2BOX
[    3.915802] dvb-usb: found a 'TeVii S660 USB' in cold state, will try t=
o load a firmware
[    3.917134] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    4.084566] dvb-usb: found a 'TeVii S660 USB' in warm state.
[    4.084602] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    4.084984] dvbdev: DVB: registering new adapter (TeVii S660 USB)
[    4.320740] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
[    4.320871] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    4.390349] usb 3-1: DVB: registering adapter 0 frontend 0 (Montage Tec=
hnology DS3000)...
[    4.390356] dvbdev: dvb_create_media_entity: media entity 'Montage Tech=
nology DS3000' registered.
[    4.416869] dvb-usb: schedule remote query interval to 150 msecs.
[    4.416872] dvb-usb: TeVii S660 USB successfully initialized and connec=
ted.
[    4.416905] dvb-usb: found a 'TeVii S660 USB' in cold state, will try t=
o load a firmware
[    4.416927] dvb-usb: downloading firmware from file 'dvb-usb-s660.fw'
[    4.572611] dvb-usb: found a 'TeVii S660 USB' in warm state.
[    4.572679] dvb-usb: will pass the complete MPEG2 transport stream to t=
he software demuxer.
[    4.573066] dvbdev: DVB: registering new adapter (TeVii S660 USB)
[    4.821631] dvb-usb: MAC address: 00:18:XX:XX:XX:XX
[    4.821757] dvbdev: dvb_create_media_entity: media entity 'dvb-demux' r=
egistered.
[    4.884845] usb 4-1: DVB: registering adapter 1 frontend 0 (Montage Tec=
hnology DS3000)...
[    4.884856] dvbdev: dvb_create_media_entity: media entity 'Montage Tech=
nology DS3000' registered.
[    4.886511] dvb-usb: schedule remote query interval to 150 msecs.
[    4.886514] dvb-usb: TeVii S660 USB successfully initialized and connec=
ted.
[    7.312401] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-=
fe-ds3000.fw)...
[    7.918355] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-=
fe-ds3000.fw)...
[    7.919675] ds3000_firmware_ondemand: Waiting for firmware upload (dvb-=
fe-ds3000.fw)...

With these changes, my DVB-S2 and DVB-T2 cards are working:
 - https://www.linuxtv.org/wiki/index.php/TeVii_S480
 - https://www.linuxtv.org/wiki/index.php/Xbox_One_Digital_TV_Tuner

Thanks a lot
	Stefan Lippers-Hollmann

=2D--

=2D-- a/drivers/media/dvb-frontends/ts2020.c
+++ b/drivers/media/dvb-frontends/ts2020.c
@@ -525,7 +525,7 @@ struct dvb_frontend *ts2020_attach(struc

 	return fe;
 }
-EXPORT_SYMBOL(ts2020_attach);
+EXPORT_SYMBOL_GPL(ts2020_attach);

 /*
  * We implement own regmap locking due to legacy DVB attach which uses fr=
ontend
