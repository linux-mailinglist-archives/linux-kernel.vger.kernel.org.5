Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DF7B7697
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjJDCWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJDCWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:22:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6AAC;
        Tue,  3 Oct 2023 19:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696386168;
        bh=qkVNIu9sbdK6erl9kbvFmSafpr2g3G8Z4JfpVx2lwKs=;
        h=Date:From:To:Cc:Subject:From;
        b=dpZFL6RBTq7AIRS+gfBobcTsfxDClytOMSsUFHaioDvLyy4GmXOucKP1uF+eVOkCT
         BgVyFmA/X2zTl2jfIkVxK2gUz5cG+2VvTiLJdBXUmP1p3hS9Py0aNRAuY9Sz/V1Hew
         M/1l5GUf/oYsoc/x2FdHPWSeNn7YN2vfWAPOQXIgf1XGbaKQMPQtCzUZ7/o63LDlZb
         3mt+kreT/KtUSmtnJ5g83V8laKU85VFDHTrQ0YXLWlHGj/sIQLZJzDxGBk/5pcqtAo
         kxqzzuVnsY3Z1gjUM5dh2nlJVhs5+zt3h7RPrXwDANloryPXtrP7eZAUxMX+NYihkW
         gkRGMXCtIdvsg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0dkw1j1Nz4xQV;
        Wed,  4 Oct 2023 13:22:48 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 13:22:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20231004132247.01c3bfeb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//DezdmeX9dBdOEgUsBvaSKv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//DezdmeX9dBdOEgUsBvaSKv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/phy/qualcomm/phy-qcom-qmp-usb.c:156:43: error: 'QPHY_V6_PCS_SW_RESE=
T' undeclared here (not in a function); did you mean 'QPHY_V2_PCS_SW_RESET'?
  156 |         [QPHY_SW_RESET]                 =3D QPHY_V6_PCS_SW_RESET,
      |                                           ^~~~~~~~~~~~~~~~~~~~
      |                                           QPHY_V2_PCS_SW_RESET
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:157:43: error: 'QPHY_V6_PCS_START_C=
ONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_STAR=
T_CONTROL'?
  157 |         [QPHY_START_CTRL]               =3D QPHY_V6_PCS_START_CONTR=
OL,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
      |                                           QPHY_V3_PCS_START_CONTROL
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:158:43: error: 'QPHY_V6_PCS_PCS_STA=
TUS1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_PCS_ST=
ATUS1'?
  158 |         [QPHY_PCS_STATUS]               =3D QPHY_V6_PCS_PCS_STATUS1,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~
      |                                           QPHY_V5_PCS_PCS_STATUS1
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:159:43: error: 'QPHY_V6_PCS_POWER_D=
OWN_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS=
_POWER_DOWN_CONTROL'?
  159 |         [QPHY_PCS_POWER_DOWN_CONTROL]   =3D QPHY_V6_PCS_POWER_DOWN_=
CONTROL,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
      |                                           QPHY_V3_PCS_POWER_DOWN_CO=
NTROL
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:162:43: error: 'QPHY_V6_PCS_USB3_AU=
TONOMOUS_MODE_CTRL' undeclared here (not in a function); did you mean 'QPHY=
_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL'?
  162 |         [QPHY_PCS_AUTONOMOUS_MODE_CTRL] =3D QPHY_V6_PCS_USB3_AUTONO=
MOUS_MODE_CTRL,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
      |                                           QPHY_V5_PCS_USB3_AUTONOMO=
US_MODE_CTRL
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:163:44: error: 'QPHY_V6_PCS_USB3_LF=
PS_RXTERM_IRQ_CLEAR' undeclared here (not in a function); did you mean 'QPH=
Y_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR'?
  163 |         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] =3D QPHY_V6_PCS_USB3_LFPS_=
RXTERM_IRQ_CLEAR,
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
      |                                            QPHY_V5_PCS_USB3_LFPS_RX=
TERM_IRQ_CLEAR
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:991:26: error: 'QPHY_V6_PCS_LOCK_DE=
TECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PC=
S_LOCK_DETECT_CONFIG1'?
  991 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:992:26: error: 'QPHY_V6_PCS_LOCK_DE=
TECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V3_PC=
S_LOCK_DETECT_CONFIG2'?
  992 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:993:26: error: 'QPHY_V6_PCS_LOCK_DE=
TECT_CONFIG3' undeclared here (not in a function); did you mean 'QPHY_V4_PC=
S_LOCK_DETECT_CONFIG3'?
  993 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:994:26: error: 'QPHY_V6_PCS_LOCK_DE=
TECT_CONFIG6' undeclared here (not in a function); did you mean 'QPHY_V4_PC=
S_LOCK_DETECT_CONFIG6'?
  994 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:997:26: error: 'QPHY_V6_PCS_RCVR_DT=
CT_DLY_P1U2_L' undeclared here (not in a function); did you mean 'QPHY_V3_P=
CS_RCVR_DTCT_DLY_P1U2_L'?
  997 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:998:26: error: 'QPHY_V6_PCS_RCVR_DT=
CT_DLY_P1U2_H' undeclared here (not in a function); did you mean 'QPHY_V3_P=
CS_RCVR_DTCT_DLY_P1U2_H'?
  998 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:999:26: error: 'QPHY_V6_PCS_CDR_RES=
ET_TIME' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_CDR=
_RESET_TIME'?
  999 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1000:26: error: 'QPHY_V6_PCS_ALIGN_=
DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V5_=
PCS_ALIGN_DETECT_CONFIG1'?
 1000 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1001:26: error: 'QPHY_V6_PCS_ALIGN_=
DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V5_=
PCS_ALIGN_DETECT_CONFIG2'?
 1001 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1003:26: error: 'QPHY_V6_PCS_EQ_CON=
FIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CON=
FIG1'?
 1003 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
      |                          ^~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1004:26: error: 'QPHY_V6_PCS_EQ_CON=
FIG5' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CON=
FIG5'?
 1004 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
      |                          ^~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1008:26: error: 'QPHY_V6_PCS_USB3_L=
FPS_DET_HIGH_COUNT_VAL' undeclared here (not in a function); did you mean '=
QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL'?
 1008 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, =
0xf8),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1009:26: error: 'QPHY_V6_PCS_USB3_R=
XEQTRAINING_DFE_TIME_S2' undeclared here (not in a function); did you mean =
'QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2'?
 1009 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2,=
 0x07),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1010:26: error: 'QPHY_V6_PCS_USB3_R=
CVR_DTCT_DLY_U3_L' undeclared here (not in a function); did you mean 'QPHY_=
V4_PCS_USB3_RCVR_DTCT_DLY_U3_L'?
 1010 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1011:26: error: 'QPHY_V6_PCS_USB3_R=
CVR_DTCT_DLY_U3_H' undeclared here (not in a function); did you mean 'QPHY_=
V5_PCS_USB3_RCVR_DTCT_DLY_U3_H'?
 1011 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro=
 'QMP_PHY_INIT_CFG'
   78 |                 .offset =3D o,            \
      |                           ^

Caused by commit

  685dbd1b2306 ("phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support")

I have used the usb tree from next-20231003 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_//DezdmeX9dBdOEgUsBvaSKv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUczHcACgkQAVBC80lX
0GxZDggAhfidZ7rmwAx833bJg85PPvo4kVbMoiGQ68yJOpTf6uc09P/zy3SBMf+i
i3ssRFqWPvwDgH/OMnrv142d1mim9lZFIHNScEP2CBHq1ofhOQ71onjoiSBvbJOr
jwjmnKwzgy3w10PllWgBTfp/x+iv0qF3TlhB+/ZrGPdXMot0fGhglVaIFmPj2XD4
4qepZ2Z4J4nH2LE5YbzRy8tKoucgvigMQz7b73jWI2r1a6T07ZLKXm83lKNUzHdC
MiACURPV33V+3hHvN3fXyd6C2SVHFmTn8TdbkrXvjYN+mbp5KMRPaj/W8X0BYrX0
hH72XJJ+LqLy1HSPSytWkVMqCQ6uvA==
=Se5b
-----END PGP SIGNATURE-----

--Sig_//DezdmeX9dBdOEgUsBvaSKv--
