Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DCB7B391D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjI2RqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjI2RqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:46:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE8E1B3;
        Fri, 29 Sep 2023 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696009553; x=1696614353; i=matthias_berndt@gmx.de;
 bh=OghkEip9MZzCQuMCpDvBbalHWA6PqjcYhAwePkOzMpU=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=ZA4VzL+gtpADigWd954qjph6z5Ibhftj8jSm4C+fVtPwm+R+Kj3+3r//Uj/kRs0jEZXeGmZpwBt
 TdofRpDm9VX6v9xrwOXTUFDXQ/1HKhBqa06kkM7eSSViBwvu8l8AmPBlSONr0+cpnNa20NcaIaR2h
 Tk733tvoo1/E2E24fK9KFXvTyLLJf+s06Zu2o1LEFSoKx6oQwogsRBD2R991PRAv2nIZwEqRdb0MF
 k86CHvv//tiAj6YEXuTrT0wY5O2VB5us6UXbqaD+cIkqHlqnlaA0xUpcCP8YjYtTJj1VHKzlkVRl5
 in8hDwUXJhpEvjIUNzaVcnyg/cUlCaT7o5VQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from fedora.localnet ([89.1.217.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1r5rgH43Dt-00K8MI; Fri, 29
 Sep 2023 19:45:53 +0200
From:   Matthias Berndt <matthias_berndt@gmx.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vicki Pfau <vi@endrift.com>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        John Butler <radon86dev@gmail.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Jonathan Frederick <doublej472@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: xpad - add PXN V900 support
Date:   Fri, 29 Sep 2023 19:45:52 +0200
Message-ID: <2305012.ElGaqSPkdT@fedora>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4841942.GXAFRqVoOG"
Content-Transfer-Encoding: 7Bit
X-Provags-ID: V03:K1:fy58odiaVbcjY+kxUmGa6MaNaBie0GFF5Apn2+K7sKuIKJ4svIC
 RomOeZuu3MGHPJVl8CM9fhlhkPxoJjlZx/2EG0JrAAxwbq9eXqrjY+eeXdux1OHUwDZQ1pY
 dBwIDbMAOq4hKnpIdOvFwy95CrLwxEThmgye2+Jrx545d+zm30/YHHtv2TYljQl8mWyQMvl
 8N8RU3vHZZ5iMA9B8uZvA==
UI-OutboundReport: notjunk:1;M01:P0:ETOXKfQpKXE=;mvvvMikhhBgZQq+4JyJexxQCsZf
 pGxxTfMJQeEzSEeSuxJAYJkhJ0CVbv/GiZNoO8sb7tG2Kqo+GOl4wTJJB5L4aveVWzHDa4CxH
 JL8UvsMZ1DjAZOAuk5o4vNtjAfYP5zGoYWtzszF0gD9sco9YRf26UFqHC+8Iq0+2QKJL4zEcM
 P/bYZoqQSyokvqn3xI9SoDl+yr8o4hYpN2vBXxBuRft2PkJQAVORFxPPGrP5KMobcHgSTzj3K
 vx9CIcCoIHsbM1FoyluhVGONoeDKKCDJe047m3FnIa8N3msl0nySDDV1DYv6T+scWKdwrfs1L
 PhYh0+SEeGYOXqofRUsFFU4bVrK/UZrOVn4Mv2ahC5s9JibAW/Hp94n/1vk/U6Y64al8Qrm+9
 k6uPBTn4tEVIj8nbUMMr8idktmXNx3h1j4h8kFgQyfs9PXRZHzEeJozWmBRQzAMy6f4oxtOnm
 6wAkQZycSnB1NxGMRw3f3acUiFWm9OEhn+HBxZC1lFOB5kdFBG7OcpfCsWq7JXU4HsKcvVgcH
 +ekemq7f5KxGNwZdt+4KKcvw7hRkJau3Jx7wpkjPxt/6ae6OOPbrjYwSitbSjm6VCl2aLe8gL
 Mvkhs3SE+AMSQUMqq748mziXU0C/8nJvK1mkVEPJCyYwDFEqBzjKO/ajtgMDPV09VzLawSNv4
 vr7qIoq6ak+RH5s4XYbs5HUKaZzLrIboVRgfs/GtYjVIVtpmHdkrU6mAYTlZfTl/MmJAyetVf
 UrZyRV1trM0LxOOpu97dyBiqtqZKrWgZzUlLVN6Eg0tvwNTM4etwqg78LWCZdoGru0zToq/FD
 Sz7Kw9/VCnqiIJ/ul3P02ICZvVI/wSRJuNVQnNBhWEgJb73TVeCIdclZTeXhgPDbVQrW19GP8
 qoQKpRGNtA3HSMzthoZBepxDjnN0UfCoppaVGDmrnhczFuP9i0StMZNZ62RGUOZqN9iqGZu8e
 ynez3A==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart4841942.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi everybody,

I recently sent this patch to the linux-input list where it was ignored, s=
o
now I'm sending it again to every email address that get_maintainer.pl giv=
es
me in the hope that it'll somehow get merged.
This is a trivial patch that enables support for the PXN V900 steering whe=
el
in the xpad driver. It's just a matter of adding the relevant USB vendorId=
/
productId to the list of supported IDs. I've tried it and it works.

All the best,
Matthias

--nextPart4841942.GXAFRqVoOG
Content-Disposition: attachment;
 filename="0001-Input-xpad-add-PXN-V900-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="x-UTF_8J";
 name="0001-Input-xpad-add-PXN-V900-support.patch"

=46rom 9b0af40bc3c064be1c7c5ba36d7fb4b8d6535fc7 Mon Sep 17 00:00:00 2001
From: Matthias Berndt <matthias_berndt@gmx.de>
Date: Mon, 25 Sep 2023 17:54:13 +0200
Subject: [PATCH] Input: xpad - add PXN V900 support

Add VID and PID to the xpad_device table to allow driver
to use the PXN V900 steering wheel, which is
XTYPE_XBOX360 compatible in xinput mode.
=2D--
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ede380551e55..478bf657efc2 100644
=2D-- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -272,6 +272,7 @@ static const struct xpad_device {
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
+	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
 	{ 0x1209, 0x2882, "Ardwiino Controller", 0, XTYPE_XBOX360 },
 	{ 0x12ab, 0x0004, "Honey Bee Xbox360 dancepad", MAP_DPAD_TO_BUTTONS, XTY=
PE_XBOX360 },
 	{ 0x12ab, 0x0301, "PDP AFTERGLOW AX.1", 0, XTYPE_XBOX360 },
@@ -503,6 +504,7 @@ static const struct usb_device_id xpad_table[] =3D {
 	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
 	XPAD_XBOX360_VENDOR(0x3537),		/* GameSir Controllers */
 	XPAD_XBOXONE_VENDOR(0x3537),		/* GameSir Controllers */
+	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	{ }
 };

=2D-
2.41.0


--nextPart4841942.GXAFRqVoOG--



