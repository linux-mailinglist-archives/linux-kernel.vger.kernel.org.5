Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7957774885
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjHHTeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjHHTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:34:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C788E70
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGYYfGReUmsx4Vh6sQig+R6KK5SDf2BQiyojguRdvsVFVVgm2N0d2sjLjw1DLlBrG+nRZIDIAE4qKAXpBaFP4LQZEpf6jo2Qi+GDxDGgSkv6+JLcbMNiCvmFOBJxtwZ9QWdLQgCaqmq7B8lChzDx1djx0EBZbo1OaoKqDfiFe9R8vUfNHuZf9Clts3ZKHR75uIza032Bbfb0mhkeIPJfcLlQ7zQ4CldzV3z83SCRVVqmKkR4IbQwmVk1SiSPVZysJsN8q3kqAvuSce4cC5/9pBffesU+eLw7p4W2C6tiZ5ZVqZ3T/AW8wIdHpPE39pPrTkaQWy8asVcskte3vVZQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+kBNHfuAcfjIYGTjbU9nbBUWvj4ICUgOCwpnYsvo5M=;
 b=YdAxW31BjHnaYC4vYW99YtfZSsICuI/bql9sGamrVx02AVcLGoNi8bGXrZuOxd4Fk/iLA49kZfmOhtBzKhMFSmPA5KLqhg9ooISGPNhFQ1zs04HyrbE8GplyzufTOoJPTnFI/jkImxlGuWuwfwS9HjG+IAJKhhe0wqWMH+AZ3ovNSZDyi9tiqQpJzIt7zsWwEUF1ni0h3FGBr2QmZGfmujAY/9bHzKi17MfoGbpVq6dZSNCcJYrKPrErdWjwSK/poSw6uG/XBzlJTX/fTpGPTMVw6spAl6+zHv7U28CVhLo6LBEskgehp0wKS26VgfWum43wGyckc2XlgUDeuJ42Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+kBNHfuAcfjIYGTjbU9nbBUWvj4ICUgOCwpnYsvo5M=;
 b=0jsTDJ2h20MNONMv0f3MQcjnv29ImmA4iob1RLmptWnt0lrpwGTTweHUr4y7J+Kb17yivZ31z3W8bvCB5nF4BWgpTajRjxXyOhQn/J2EjFwXnlrpryF4OhM+cemEmYToZgeN/PqgtvxPOWOqjfUkZRiiKnAz5NZXc5zHJCWmLO4=
Received: from CY5PR19CA0066.namprd19.prod.outlook.com (2603:10b6:930:69::12)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 19:02:58 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::af) by CY5PR19CA0066.outlook.office365.com
 (2603:10b6:930:69::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 19:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 19:02:58 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 14:02:56 -0500
From:   John Allen <john.allen@amd.com>
To:     <linux-firmware@kernel.org>, <jwboyer@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <bp@alien8.de>, John Allen <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Tue, 8 Aug 2023 19:02:39 +0000
Message-ID: <20230808190239.131508-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 47075bff-13b3-43ca-6d20-08db984214a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n76Ot5y8UyRxoyLYkvPmJvFEP28GEiVKywO4PPqj07mKWvQzA099TnXdj+LqxO21OuJqjuCRzZxxhdobuFnK7YNKvaCLOT/2Q3oPfYSnoCvLUkvlUfTn7BHYlM/958UUJ3671uunpVVGtSnFYYt2rSfEFP/ySeJqgtUHfDl8LlkoW2CbjSY8B/NilHeD1soBt42FVfP5GdKTZ1rn2osZG0B063+dqv8nVhl9xaA94qn0zOpM/1NdZQo5mkXdpA2v1Kj/g7LcQ1TXYEoteNth34NSdYLt96O/Mt4RtX29BygU/1upzb4bYps9ajxu+WyRI0z8w+XV0hZrWRxL5rCBcNdIhU9iKSdiMLSObdsXfWO6G7FUB8ZeaMNyzKyU/FijOLAIzRji38mSKd743HdHbbqQ5x2Pql3g6nuHlqyrQm7z7ToPb680+ZCZSBGr1AhqRy3OTwVeJBNJMvdmd1AapUHoNNPs2923A48MbvYtWzZrkhjegM/9mCWzRbkftrG70xYzhIvOOjsFBO4GeuEcoeb9XGhsDOy1rnwB192lfw50NG/3CjXuM2WnGKn4E6ll1+XN8v50LY2CK1E40T9MdAGjL8zOF3YsNu0hgcf6UmzQSTHkapbBQaj99+H1B1O4wlblsWk7HoBTpkMu9DTD7fpDyYsuLnqNhur+Zvx1av90PiB118EdiZJrolwsQrIMT2QqP2u+2t+HCA6qUDEcvaSD9KnkFIMR9i15g8GwjpE5J7AsEY+umRiYxaxVtOVtn5ish8lOq+Qb8XAd0ltqSWcTaKCo2NzttAVn0arjUj4y1iT9q/j4WLmFHJOvsEs7YU8yqQiQHiMjsQHhQndGNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(186006)(1800799003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(2616005)(36756003)(1076003)(26005)(7696005)(6666004)(81166007)(356005)(478600001)(54906003)(19627235002)(82740400003)(110136005)(16526019)(336012)(70206006)(70586007)(4326008)(316002)(41300700001)(426003)(8676002)(8936002)(5660300002)(44832011)(15650500001)(30864003)(40460700003)(2906002)(36860700001)(83380400001)(47076005)(86362001)(40480700001)(36900700001)(357404004)(11179615003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:02:58.3809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47075bff-13b3-43ca-6d20-08db984214a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 19h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/README                       |  13 +++++++++++++
 amd-ucode/microcode_amd_fam19h.bin     | Bin 16804 -> 39172 bytes
 amd-ucode/microcode_amd_fam19h.bin.asc |  16 ++++++++--------
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/WHENCE b/WHENCE
index 3f24963c..e8841193 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3923,7 +3923,7 @@ Raw: amd-ucode/microcode_amd_fam17h.bin
 Version: 2023-07-19
 File: amd-ucode/microcode_amd_fam19h.bin
 Raw: amd-ucode/microcode_amd_fam19h.bin
-Version: 2023-07-18
+Version: 2023-08-08
 File: amd-ucode/README
 
 License: Redistributable. See LICENSE.amd-ucode for details
diff --git a/amd-ucode/README b/amd-ucode/README
index 1d39da3b..fac11524 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -37,6 +37,19 @@ Microcode patches in microcode_amd_fam17h.bin:
   Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
 
 Microcode patches in microcode_amd_fam19h.bin:
+  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a10113e Length=5568 bytes
+  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a10123e Length=5568 bytes
+  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00212 Length=5568 bytes
   Family=0x19 Model=0x01 Stepping=0x01: Patch=0x0a0011d1 Length=5568 bytes
   Family=0x19 Model=0x01 Stepping=0x00: Patch=0x0a001079 Length=5568 bytes
   Family=0x19 Model=0x01 Stepping=0x02: Patch=0x0a001234 Length=5568 bytes
+  Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116 Length=5568 bytes
+
+NOTE: For Genoa (Family=0x19 Model=0x11) and Bergamo (Family=0x19 Model=0xa0),
+either AGESA version >= 1.0.0.8 OR a kernel with the following commit is
+required:
+a32b0f0db3f3 ("x86/microcode/AMD: Load late on both threads too")
+
+When late loading the patches for Genoa or Bergamo, there may be one spurious
+NMI observed per physical core. These NMIs are benign and don't cause any
+functional issue but will result in kernel messages being logged.
diff --git a/amd-ucode/microcode_amd_fam19h.bin b/amd-ucode/microcode_amd_fam19h.bin
index 50470c3f461a068e832a1ebe33683a041d4515fe..02a5d051d58b8028275ee6a0b091f11f8d1b6e27 100644
GIT binary patch
delta 20542
zcmZ^~b8z56_wE_n&cqW;Y)@?4$;7sud}B^*+nU(6ZQHi*`|jS|{Z-xCr>d*Y>F(<4
zdj9JAoYRGYph0zD+#<4qApe!$e+DXY-hadYOQ`<|(f&t{_MaRKx%~fG1_3LNgJVVl
z{U0-+<#F8j05KFFDheE=pAP8%yY)Z8e^2|ba?!lG*_H})h9c;<wav1sTPsas&+C~?
zt+w>ajFKQ+n`rnHq2st{7<r==N^`j$`e+|Bdj&BczbEn>`Xymh9xn(55h{1PelZ4(
z8)Cd2J()0bW4j{$oYD|O%1JLSP6mi8dD@uqn+Nk4Ni+EdNRK_hB4=x$;+<&Mo+g{&
z*KXyM!$#1!qASd{&9SB02gb{<sLSVOpOXkBO;hSaCG>Wk>5TSb+4Id$e=iKOW#2M>
z50LG^X$0N~_F-(Rr6<It&fK4ws3Xs~<D>Da*9EC=6h$n7EYmWMyr4wGa})a(=Jk9V
zwIwD<`_dsUurwAYS;82Il!+DiDt+=zEwb11U_*cb|Me&$(i2a816XMfU9IWl(u?Jp
zY`(;-_)v85_Y16@$F{@bkS&gXmDI?HTK8L8XYeeBWzf#@Jc|quRbU2%jC<$A=U#+?
z_2ZOt`PhKYu>rN`KbDs#C|}#Hx&o6vyvxk^H}J55Il(V6w#>o_OTAehMkYV`=U@R6
z7X$bj5vX<)>iP|q1QoZa4Ie}Kpg78Q<63ABGe8AN(6d6DMh&giP_mo#p{L|)ZfQ9R
zR-gR5JiUHf?4qi)HS(^WLgR9Og<7g{lda}@ZH;STPW$X=M=)sb@;B;?(3p9mi#;H@
z8MBIc-}rXWi7sVTH5WB@HE4}W<if0RW*2D2+ld4(U#!Y!m;H97AzZiZ!m%rcaNVc(
z$@W{1^Rf>oEd{G^zO-r!E&t+S`tB?GaDTxXjS_=WwLsLII{?drAYw~FF;OqM*BAHf
znwA@Y9-qk=K#Yvk_{5*dO9Ue2$V^uZ1C^8e;M7(sId7r<#QZ6)UShs0yXv_cBmfe7
zCu22d9X*v~1D|ICM2=A4$zel%rTd^2##O<uK^qF~qRaUYsmlr!+Q;-GkwV_MM@TD@
z+;Njq=n_1}!Lk{U8_#dLU4Su!=M|$d_91$3It!iILH!>8`S(ZNhz+TS74M}ZWNrUz
zF56-OcG@Px00YtGO)|MbTX*aXG=Lb;C%~*zC)*-QlBEct__EWii+AUjlSK$tpYs8e
zzX%dk4Y2hQoZKm#fq$g%-*OcZjUat_nLm~hT;59{Z`!wT&2iUT!N7ePfnsyN%l}Gq
zix(BBJDj_u2p83=?enFz%HHe)QT@5{T&{2H5`Bb-?J2*6Ai3T--T`@34X|B0m0n`?
z^v+7O)QD6KyNT2MkVkYc5iFwW!FBEXexZENvaPAwazdm*(n3(PA5a65b?&sw8Yh1A
zzcoZ!B=*`WYzT#Xlf$nIidpcZhqxVTt(IzLmci}vIqn{MI2Gk<G?E+6K?xsHwpyIs
z3C^Q9-!!bmk04Z`23yN90nN~KwO?Y$VJ|--qh5}(%CXc1&LLgbYS$v4Fw^+Se?JFd
ze&-JVFqe>G)@I?p3A-r_RK(S1t7ff}cHKwZ{;0UbFahDD=zPAYar|ZTypdzX_A|zF
z*5akl>`DQIf?M23a?#r9m~~GAv&zv%@)qOE@&Pd;-ep2LFWVQ11F+xiHV@>ecUpa7
z8QavpLww2=q%!#yJ%dwZX0pN;FZB?Z?XcnX*Gq977Lvks$^Rws686S<OqGt=50^i9
z%x+k_PgmP5EP<#s`Y!K)w)9rky)MH&Yk&_}xN(4EhMRhr><}lr7#EWalB)=PJ)BDn
zLCKC0t2OzmZ}&)e0jx}S56QSn{Hp36IUcukTw|^wT7=W9`W1F1+#^BVMqCBRUSYCp
zy}ySZ3zVaT`{2QQ08gR89x(~<l@~|M&t5@<OK@5LY?ythy@h4J<8E66XkU?=cjRLY
z&c*s~D<=f9)p)0X;j7H9nok@92P6o6*uDE^Y351aX?jXcKt%xdJ6@yqu4wGT@)ya3
zGt%A=sACR-YvZANI5fh&)@$L%z0E`t5qjZ503MA3y$aH$<S?`v15<{-3qNPdwRWR0
zNUn%{5+ymtb)D#~J4O;#C(1wk+=QBrkNumC_OY?lPRgc@Q$IO$DYBCI<@OWR7Uu^G
z`Vk)FbPB#lAg~2CS*D{={#MDN8Sg3t#PBZQjeVp9V_k)c13m41z``j|7QdIHTjW_W
zQ$YwuY+&WbQ<S43wkBM4uJ|$9qp@819(qTpb#-`M9^;P^h-+aG%2zHVn}k0TOcqkR
z*5{O&m7wvn5G~NBFS}m<a2lda$y-6R1;YvFC1ef$0);u!R(EJAlQjH64;xtRf*+;Y
zQR;(4&IF}LWFkQZa~bL5uNUeZS|m_<XK>99I;lA%vy#o7iStT-*LFQyA6?h-zYQnP
zkXlrU0I&-+SAk&I*)MwIlQv9G!t<4j#ri#EMaah$E2rB2+_N-&7b}olR<gc^;@$Rd
z>XU09K;IXs8<pEDA^l3KQYbd$TM&*An`l+Zi(>Cj0xt&z+M0Aj#o?e31`cUIfqC((
zCX^V18{Iz;CncA&5K-lFT=Eiia$$+vdc-J}ChXWM8B&Gg__bJ3FPeyO|9Cwas&tL-
zYM;5g4n(TQ-zTfBY(OZ97@=h|pJPEeenE>Ake9iZkM^3nJlBF-W?^DRAA$!rr=7^R
zo&-4(qbHDh%dE+2?kQBhFyF;Fdz9P2C3Rmd`C~Rf<1)hIVQYHb0r#gc!M~btXc3Cu
zSGA*GA-Ynt#pGUW*@j@2pxohIllJ!ht7UEa=t^=e-|rNZ>l)2raWc)X+bN?c@_(a>
z0mfer3(%~RLMJeoV@gIR5FUp+c8^5tHm6Jt+IWhf9wEf$gYp{G!+0k8XtB+$X?cms
z8BbsC&)6N^-O6w~202`>b(;dPfre%oH`<jPZ>V<Hn{N-&4y}W}Un9Ts(?K!g>9j<Q
z_*)<HlIxk4oqdUN2VyaeS_)A&98tSr0aLZ#zt%KUsvp`xFe78QxZjfKnj+(cu36Zu
zAJ)pKb=k^V*gh{0Q`O6D*f;(7o(7R{uFg%4&PZPx*_c`gF}AB29|MIJiZhNxrz+ZT
zgFLW|e+<-0>Mx$q8=*}!V&k0rIL0q9FGq^C4PVH2@`Nr9vXg6<COx3U+RF0Z0{8-{
zB;q(vqx{=B3FKbA#NRL{QI>7xO0c^<=|_%E0_<1l$Y<|x5{(;R;(eJAtYEcoI<IE~
zojcG%)aW;}7wqo!?+<ydbAzOAC2owVQ?IKk1iysPY{8$TNH_!j1Q0Wdkab%p%MoHs
zJc57{T{Uk{V1}4f+gAIZ(xnuN0tUseb{)K(zSu&|=3V`@VWpM(EsJujOox7kiT6jV
z<*#X$kXF^+i4a8}t-Rc%%1}7x3_E8PJ?nCFjP}-3PEIBQWEZZ1d@f;fzcU#dT4>d_
zgYOQTst;WL38@Ce_gl!5M{`(MFWc7nR~0=Ee|kfC`FL_O@C{taZQmoo0*6)lmUpyC
zRiSZytHqsSv&imuw%Yrg#k1!gA}d3Bmkn22`Uh-fk@y^qlN_1$;TOC@^-9u+1}<z$
z>s1EC>$6MSdCR)bFlb@$Ak*MQ>Rr7&Zslb&w{$)EgQ@4qW~W;WzyDD<@dl8@|CHcg
zY~U(0Bsar9zJBrOD0*aj1_qrN(x66s)16!FCBP}CeeW|?R5k1wd9>U>`R{~RGT;~p
zdtYb?;GpLwc@&w+Mg_DDU^zGTzwj&?^hQ7dv!p4>0_}S*Yw5FY0Z9h9%%bz2Ki@mQ
z^(2Hg7DvkI?t>Owr92Hq=}Y@`c-$(TG73h2m>!TKD)^R57j?750K^QgOgPXe5TG`-
zn!`-=sBoMoA(j1JU1vr49uXyQR<tLto#o6GZX*}44{SF~mslykXr3`J`S%^8A^T0V
z4pq+`kt6=n!=-l`#j<wXNCSV3r+6Tn{~pzM_@*SKzbBv@PkJ!PWCgGVc%;M)6o7%-
ztkyp+FE_yEe;<XL0vsKqqS&LizT+>=S#K{7vq?$1+I1r#63nF_P<#!6hcw$&tKO=C
zG!Qr&s?|4DtT7rjFC3{Q5fp6u4Lpnu7b%QEJl`e319IOspTSns%dfW)7$c*$l|}&#
z^5p2NIHLGk$dj*`>OaEJP@^&)pLYzu!;_JaCVys%;J4s(0$yynQibtt1ap_APB&G#
zNOp!YF)hi6(d@9Hj>^sKjTQ)skP=(5>qxaXFuZs*AP-N*&Xel4xaS?PUD>C+U%mSW
z{a(|Xhb+uRVE4!hN)6S&9Z0wBE-L7k^{|`7DQO!x-4bvM%cSxnsec34y|cuKwDAco
zdJ}~q>#3wafPr3m$W<#CPm4;Q*^#cGB`&yvuQwb`bK8%<YeRhe3|U-8$bM`8EVP6-
z#uDJ2&BYsc>GRyN@rHY1cDlH<i8i9gsHN94#&g@|G^A8*ib=^4>OOl!UZ;E8#GjWp
zCSAS}4=T*_Qj9$r8eHpnd?&FpMlr&`+%qxK>hYme0QC$ni9f~R2<LYe)O|L#nq`W<
zcD2Y^Vu*g8QE|RU$Ugpj4r5=M*S0O4McuDvu6Q9a%0W)XJ>08gV)>(+IvVal%8CLE
z6f(Gu?R7|>kV64>7-gc%yUe~Cl5KYkGx-LY3Nz+o>@ox#p=o#N4U|T%J^bI)(Ht;a
zEtpkQK)^KyxZbyP1~bNK7+=nHw_XOKWVpdUDl<r5p-;|bn%g!s#c!2HFX>)NNNp2s
zZY%Vj57cK@WeL%07M&?M{9b&6A;x0$a+FGSrWS>0oaU)FpBB1)R8IrUqU5aXvKo4g
zcx#A}{<2hZu+v!;7-oRSd+z(98)*okUd@pgXk~UJ?uK(`eK!r!($%3%PwROc7OmLT
zGSz~`9ac&HqWu#oWa44lPd>1BW%8@DoJzN8oFFGdU%}`J;gDGH`i_9<-MsjYhMyUY
zEC5d|-gOCF{haW+Mq#3TejGZtFpDJz;>92E81|Kc>#FXSN>z4z>gTml-!80Ueit<c
z+9tq-QhX}nzj!l60};s#AM~e%lMKWSTkU6q{C_srgj7O{z2l#=eDw_?Rzj1uwb4Hq
z4hfr9{N=^t>QHTA@~8J7F|P;r%!O|4&!rr7Nlu$IXA+PbVClv8)Qh)caDLKL2&l;)
z$6ktRlkp{$QGrwJ@M!gc45P)WKjIVv&bOEtP>o#QJ2_UPajjg-<#2kARov}byiD!_
zn8m?1*T68@rgwW=8CT%Kd(A1r7O_8TjSPquFG=1b_@fp|IG++)Bo2!EgwBGJjT^>a
zFD1e)y>kB^Q~S@g4nju6SxI&(xRL9oE*ly?U$20>j*v2>;@TD}PF1VeM!RSN<^RG8
zy-V0GAW&``;uxZJ8Tj1Rt|l0p%kteqw6~2hV^w@CkGGoeNBh=c>iWW@`|zQRmRg-N
zp+NY?qpXgUey^UJDI#!5EFrA!{BHDz|Ld(Zwochpx>@eEVQz7ES3(Q$r?@R*gY=TK
z?zX6P;yC_nm&{sa|3-q(3?R(}!Wbl*{H(ZD#-bftA$<QCZD;DxKfj}V4k30ilw!n!
z1=vG`V7Ah6N~Tw(D(qM5qJ{t3b(;+*75`%*z9dpf$(-YA$S($Oe2Se6ttjax;n6>o
zE>Py-xSN;}sZ14V%VVfXT}ZurEXQnw;)Rk@sx{G7!alz1$<$RO(H`;}m<?DNAM8oy
z^+St{@>#nRUc-YVDor-<Y!VR&u0w%5$R<J?PY>^rEr1ec>cLA443R3G`5`o;1NGd2
z*+<N{6^BA#OL_2X*Z0|_yXRne!elAInTs$GJNv+uvr_OLgV;mB^AZAg-F)UzbyELu
zDezs%wKns^U_Qx_l!4?QfZ?2b`>5?o0(DGDmWE0ZSNHV`i<x}CB4kV8W*6KnTYq`#
z@{{OfgmU|s+OI8nkt$5hq=KaJ8h5r)#T}u;nSbQCktQoDq>>o>wnW=;fuWcPE%6hZ
zkVR_)?;nMxMa=UKYD3y@E;Zb}rk@Mvo}_Ta<eOPghkhDcf88n@03~H7FBQfN;nQ&R
z4StvGn4C@Ogld@T@d_v3=MIzX&gaKu9CMBj;*H*j!RGA%Qv5G&#l#WOjN7Aq@4Z6Y
z!>+S+e!X1IR9#d~EqH5r+XD}~qT{X})Pds$P6J&YQAE=}yS7$Q^Vxd{P+B(#G^h=a
zz5^o*FKB*Cmv?_f0h}_cFOVnSp=K5w;fTOOajvO`uD$4CZFKs$S1c*#vYu-V{(AYm
z7v%5`&R@}g$6a+Oy@PzFQ#4n|Rl;a>u#Xs<8}6{OI$h=u@}m?vz^{1LVu`p$N;;69
zCljHT$JTC${QNV$L6+KMiS>7?_i47|uTSa8Y-kyqa@sDK0S+%Vh|;$<s~m0Bat)hk
z4d|L`8H(_`DL<OzY!+K9pn?X%$jVxU$+^hifDwts3?{Z4-`u!qGwmna?c%Q*5RewO
z-nDvL3Dk&cc<I!!2sAm<9*L<Uwk;M;>3<iD4F@I{_w`0A5|t~8*W~DuJlv8EbC_yG
zm4tnrHCzcVz>$uGAb$%I^jmW54SDR=NDjB>AEAJrl0T`+%c9N8{@D)(S5TE)oB>{p
zOvq3EsbmGjcFFGoT>C@v@D`Hbu(~v2`%|*bsAS;lk6lGIIgk5Uem;n_h;J-N3pW<6
zJB-n$F1S5)UXz|=?^}C?ZfJq44%IvFN)+Ga%wf|IK$1+`D&&u?Ii7l^TzyUc9~xEG
zf3A_=Urh=G1{>DE0n^05cQ%DNWNW9v)whS@ASaY*?IevXX)1?3Tm)s|3F-gRy&g;u
z5K`j*06(<<6ZriX7yehFvoP5mZ9-Jlu=|?@sl24HsH)Db+kgmIaWTnTJ#QJUH)E9d
zimS=8_q)vIT1w0z0%2;2oTmpX7x!$SlsyB3_?*e#QS>_I=OBG|Z<Uu*9~O53q)+nO
z^5ZwgYfJnVUac<r*(^>BM}cp2-^pMW4By6a>V(|J!fUu^o%hrr5mJg~onFsGKCn2E
z3RD}je<P@-)PUce;YT)3tyLL%qK2I=ixCWc;49!V2bJ|%V(~3yLp8hM{?CXad+0@i
z3%(w%`byL<$Q}VPppKxJ5`74%yo!nl)AfqO0EVJ|YS$X16H;MaG970a`|*qzf{AN=
zFpilA$Lz*PKOujLa5yuReCu&O)I)5$i884uEn_{1x?TbM1{C<OZ=|)@^wQG?<n9tn
z`r624La?eWEkfsXEX>b0d3pgeU{WZ8wiI}TAU8|CPiI`S*q$n@-sW__Q2sphb2mHr
zmb{SUrtl~C|Eqp2t+ZhA8(P)V=YM#|f-BRuqOJRbYr+`trZUzVJI!+Pa<7hc17fy2
zTi=#m(IWWF1EfC8mmMhr<w*)yo;}%W4l=q^r9lhqA`&-KTF6i!m{B#qo1aq+Vndv^
zpP6q{Y2!;GU73FL9)7Vz5FZw7GTbJ95Y32<pJ9FA!lm#g$rSLvyW@H=Mlu}Mhc>4y
zFI6L6u|r5syTv|R-bixMKyjZAQG~K{JwN?ny!v`b0yLyp^#}b{oA|ls7kV`1L6X20
z)m=K&$!<8eob^B%kAUfL`zhUP3)qovXxNiENOjAWu#~<`7(&D_lpv{zX{!C;q`sF5
zjUAgP@a4}}F;m?2>`)QBQc?zi3Kwzjl=3j`Qw=DEztGZ;AR3uB@3j1LSup6jGk7v&
zI|21G00{4AHprbVY>PD@EF?+SZ}+-IO~<ka^;e!TrifD_OrpCAZ=NjtP&GRkRgQ?W
z5Jn?zx228?b%JebtH`zHGRoF5?VMtK^S8pWfv#H86f_cQJm~?W-TG35$vr`%d)aE$
z-tl$J4;6O5y?f^q#&7wEd;x(1$SOt#g(K8PAY8#o;{Dr`3)35>UWjL;)T#00D*-WG
z--Ex}yK4zviU2D9%3vy+>#nY@x|(vfu4(t;kGJly6A>-1)Y$}YR*pKJ>5s)am)Xpn
z%uJn+!!&xLO+--@d<x!OAGpv;V?R=J8UOo)ZicT`PCu2?*>mA;<tZQg5a%T|%r(w6
zfJ+}TStam!&5vkM+z<~=_W*0gx<naazBw$f1NQ)fLlcH?rD9g7ZtTWipDj@@#u3K}
z>h7PeD>--A&<v{I`(i^gDj^cY$xrwpNk2*)sz=k=qVq>g-JScL6)mm1SFYb3?0(S+
zUzuucW^9-Wpo&~*BfJq7s%bp_tyk_IKsmv3+6izbCc}1kQs9WEa`x>MDAr4op_ev%
zWyWk!fuhT=EK%k91Ev^`G&8U!@f$Da2Z#1o<rL3oc*>0AY1qx@9$RF{Kh(``na(xe
zdz_0+^@e_=h;KD}`?$D9ee`g~87rfBcLLBZg5Y1a4~<XUvmA{r>dwtV32HcOfNE&j
zccl^PxFmuSnA0y_5m#B)-k&UVTUfE-V$sZdHy^>+c)^ECXyh|bTlayLSDqjBB%N*r
zE*Z@ZVvP=Ib(EP}%rn9b`0}J4dN+$LN9WdNo$Y4*kexwk;HfB%FVPCRiablCCGrL<
zlSJw1aFO-P;nGBHJ`d^0{|F9-0NWo#Uih6W0KBHGxel;{KUXMNXqb46T}h<Wo;?0@
z{E7N&Kw^$}Taj7-Y3MK3i5B)R5y8!>sf@krrmd<cv3iR?r@Cfgc2C`Q`(yYX$>{{Q
z>v8rQ<)puSuXTt2=yK<oc8Y97=&I=#7c-RZ82teW@<SCEx$MoIN8}z<1pt4E8!cWl
z-|XBEB2x0MxFTG+esRg_dO@7LV4=e>T^<fKrXJLmXX{ZbvW)8)LIlkcV@jSWMiZfn
zF5)o3m6ZvN_={z;!_nd^@g!ILuXT1u$T+8}MTS<S=`LW6j;76)x&%zHJXIE{naszA
z%5hqNqQelHqzJ4Dsn50rARUFQFN%a9BD6Cjo~M{y(UL`DZpL+8<Shde#*%(SrfJfr
zR>*A5pepvR%s{LS#L(h%UH&G=({VOF&PYGm&&lNOsMZ?7dVZ_DE;M-8&RuC7e{Hjk
z`aW%(y-=*(Qt4)_weFnS8atidBQ{lJ$yI^iRPZU|f>_!rz4Z0~1{mShMd4G#zsu)7
z7fq&U$+3+x16!>s&NNh|#70N5=5XldFTRNNU1#!kR@|r|F|#|%e}ke~>{?b1?i@fv
zB`{3L)jbaRFP|OP<`LAg1`Id;<#+@?hAXXdx~5{YrORlAhfL4Zu?+h){udEyzKJ&d
zb_6Q9#M3wb^E164c+TxF!Rf`2+TY{uf-%+|K4H>*zL*HzXLh!FA6bTg40{m<_o}j)
z5vhwT#S?@tS;k%!6P-;;XN4WW4o|wXuU+d6&nDHCKSVTKw?esXZkxcU`RTnYmG1xV
z9wIWTH!Gmw!*!G;$=1A$la+_ErXJo43u{Z(#RlwrYA~`JQ1|R7=!f#PS905j_)$02
z&m*f#NewC5Dh->ZZoT*d>oO>XFP<3Vq<lNoG-0f{w3BL?tZGR9(&m>J2F5!rBD~V3
zqcg2X2ghvCjYTyz=;m}W@HZcw%NFm@(<;P<B(O=9d**{-MbR0Zvfah))YH)fJ_lNN
zzN;|N5y$5kP|%kbeRc@x6TvVH=U+ecX@*u;rPzCJUNTfaZw0?gl<jOar;7RE_C*0@
z$brJRq2490E6_~nK%O|S0~yas&6|26nE1(cUkmpc&=+kC5hAvzZyX<go<sPP5woEa
zTAX&Pc-D1qJ{N_9v#~kFh#D==$YDFdN5u8v_{3fxz|e&vGe^RiW%wN(rx11pDrO(A
zQB6w3G`=c@?kvm%Q=0Kj0xSkkd)&WPYfYsrMTOJn$~!Xc87e(Fv@s$D4_y<jx!tXx
zMfur|2AUUeQ5MM0vJe`C7M{y5orW;If%h=4rifI3@yM2r_-t=rDuZL}BDvsLr1HnK
z+niVdAyqFmzYvnN-8PvaPxa5jDx0H8n>ypo=bM5mmVW0qm{zj~?w}{*jt-@BMtLhO
zFkDn`GKTm}rT%69%qy{J_|GG5IL^g?&T94?3stN#H*^jBl`eX9Jy6}FmfsSvZwuh_
z<&UQ>l7pH_y_xxH<q$Zy2Y<D+*4!=>AOZ6Pwrk;S^Hf$x|3)stJkECe)X;h+hOT%q
z<^BX{unqhMo-vE~!scL%6LZuzLJ$3#o3JWz{~p3)K0;2XedfDkvz->oc1OW{=V8#O
z>QXjr#sA1u3)n3fOgLL=HQ$n+%=$3_5vhQ|bkDQg{wu1<KIpeI?H>vbj|{;XO)7Oh
zpjo!3h%~xW@Y~T_r@{)SPM;~Sc-_)uR&0J=g9mvYY&UzFCM{w)A!Q1F%ZiG>2ExZ+
zm1jqg@|!jPc+|&wPGL0SO}8c@26C1Vl%9|82HN+|E%#T~=IVEiTy?CoTze)9H#uHD
zE(|6Ny5+4-(7SCPy0P0y`=i5;E9t==zz&Ulvy4uaM(YBplZ_zJn1~P`@6e9JEvWls
zauEY-e6>4;Ta*OyE*q;(vJ?T=*dbPLLVhWN0%Bt|@Xus^hY}~=!k-uLs9UASN8`b-
zDpqLEBeLRy>x9FFGR*)HcJCJ5#TBX0=s_P`d74*h!5Ne9q4it-&F?ii++6)=VDi3j
z3904AXSr}0oMA%aB_miCiJn^G76*P|5aOj6fs`plsT95caqp%qnn$0I^*R(5Y0%en
z5mVmi&m;9O8T|Jzt4F5wWSls2tO8GSut#*NFn1iztp#+m1)0xZ97TkAfggL~NMCZc
zm?N3Y>er_<>=A!Ph9Y$t@#dCs0rVlv2fYdl+Ea6<yP<7eReNt@UafV$VHKsSYs0pM
zz;%#tjeez9&TFm}qcq2O<72pGJfE1%6WR%w>zbr7a~|l%(mNlTmn`t_@W&#5wWi<{
zrasf3C!lwY;A(~1X?r-P9e>#)-zm4tQUsp1kN?ShtCapy^*nw;5^C3B0Nj8`h><uW
zjl(Ot892k6gy0pA*2LyTd|di!o07kOrC;CZ+gJ#`(%Px`T~qUoiagtRAkZ#4h`#H5
z^Dzu`IA3kBFrpj&gt76sh~hB9Q=;3>A}fd_J#XNiD{iovTtTh<A$pN}{Js~~&~!k~
z0M__(oHPHPA<~jDz1R!B0p%Uy%(Axn^7$rHY)`5`BNRxolJ*8fD=6eqWK`w%Cs2FJ
z{>|AG!~aYR!;0WFcbW@SATN^wod;b&%@TKg2`F^`Sik*vs52DV%CW7S?`K%Q;Qter
z0ms?8Px5pp*-gix7XCTY{Yi{rf>W_PPdxiX04Z?hG)z6ku?D+34OHMza+>D}qm#Zj
z2YH(#KrmP;mBk7hG*(aai0F1di1-#1PTj0>?c7#_L8s36w_}~<3gvKl*+fhcIMeg7
z7Buf3R8`sW>T?*y@c>MPJqN0~_U8GTbFx>;+fcr-S5bkIY+FBK5cQyeA2VidjgFA%
zbXY3`T_uGv7F}etz!LFc=}EC1obh3jpNah}t92qB-*k%>v7pz8hScXm?WJj|U1rAO
z+?vMULZu7`w0U@tLifpOHHFF69Xk6Y=Gm9ID4|hh?<l}3@l2&u`?@z6vyoT>?{sy6
z%&NZva=nwQfk3lnvzy#u`obKF4MWdCq+5Z7=-y0+WAn-dxSWpufEFyq?}t+xl$5t+
zNc{=^W&Vw9M8wv0_!k!Te1A3YHl0kq7ObaEkF@CS_K*4kjae8+tPx+pNcgR{KC)wO
z(BoY7x^8m=Hov{Plg;D2oxBd@Ue&AwsApr{3?#9qxMYGj<G;=?k_9=PPf9YujnQX+
zaRVvB9vnA8V6d`jT-j+@_^QkQ?RNj{2V^LKkYGy_U(Es)q@7?BvA0E=z20*@gF=Q`
zm0X~mrr-OV1x{-?1~DOt6c5r^+}h6m8*khB!)Z%UnytQ0nx!@dt0QMWNO2HwAlsY7
z@x5hvE9j(VjJoR>wT@5qpN5y7cIF3X-D7Cc#!46kAW~!@dz91Sh&n@S#R$9OH`OeJ
z{K~l3Pvo|IRY=*XGCfC$yP`Q}f;g1cc@_NJj<pJ5xLIULWcj|khzbaCYD%+yA3IkZ
zhp``YjJR-xT=aF$qDAyFQmH`1{Sh4ZB>B}q81ZU$*#jLYT;I<|QnIA?l45!xNDUB-
zwNdB;u#!@_t*l$2JFdH)!ZAospjEcEhO)98W~tzC)1dy^av_CTt#vl4?HZp7=m-SJ
zdHdrtb4gF2{_(<tSs8YkW+kPwl_v3^sHX^|>N@8y;*kbj+VeE#b=eS+R>ZyC{vNz;
zGdFqCj#dJX<-5WGuO=jzT}`PKNDsQXVXqIspduM^qO~mkOR<iOV$FZ5IarJ5ltU^+
ze_^zA1w%vN%v~%%7ngPxI0Ka&)sys>T>Li(h^tT=P9Xm>1=Pu3_e!y*P-k;0;~w)C
zBOH%Zz^-tO`rGlbwyoGnj0V0y=&2VU`CayTcLy*X_3Kka9oz+IG|dm+rn$hCf1c|A
zv;oymCC$s%q+9ePt?tra3Cr1+Acdg^WL$HCw<QMP+06KHUgr1kOliX|*_^tEvaNS5
zvv0UtT<_V^n1`Ob=?f8Jd2}Lj^2?a8a&pywuh4+jYY^kTb4W{B_4^!jq9}$|jby1j
zmvEizMe!{1?@Qxd6Ut6im6P9pT-Nr1zNkk5)K9v;n+0<Nv8A4V_w$Y2atl9%%eXz_
z5yekS)`12KJgL`f=TJxLUu104=$GTKKbptFI;iQ&+(p%OLkv(Io4F!Y5fdm^BMECa
zqi?r^a1_6N9t0FexWFc+xej^{wAM3)`ARggi_K5uLkI%P{CXtmo0D3V{}n6&a>3<x
z;qtpjSW+{ozX=Qkh?Qbrij*rfsW6~o7r2{hVudN;K1~XR1X{jgR<kOfeQsXL3^$ok
zhs-N>eh!hB3nq77Y8ueG()1WPrQwyRBXuyU85Sy$VLb(!FB}<wbeR~`%dr?v;WbT#
zp;kN#3>-uZ-{>9Z^+1cKQFuWBl)Vy0xO%t)>DyB6d3+r{H!a=Qx9sjY-&G^oC`su_
zIx{?wq~I^ZxlqY@3bYc36V0-=U9nw+v6OPc(}|1F2to*Q0GKKHg|a)>Mcvrv{ESc6
zdGcRKtjMK;a(}`_Ls#v28O-u#RFXIy%Mp(S6eE6HZ|Vh#^*lNPI9qw3x++N7weihf
zkx<zNNGSuI->}Nlw@c!Ps<~|Q_77}L#=?4s8OfzMS>D}dGarn?)mGU+D!W8idT3k;
zu|~ov%xLg4Wr*oEDY~J7b9*}tTU%)xb7nSC)0!*05a^OU055i@G_>G0q&F#sl9C^M
zv|4DIQWYJxwukdC+WZOpLvQ#lX>c{RF{wKl$9s2$S`2p3zwy%j5MMxIz^LO}g6P$9
zV(^}ljOm%i0V$XFrHDJz+|0d%PK-pZ&W}%Jafa5CNj1UwIY&R{+6v#{*Fh7c%w2TD
ziL@Xp+JY{Je!Vr&$cP@{O)A0GK<@CE+6W&d{%#+A-FbsStEdPx?*7XyE}%6}c_v2~
z&I#Q#Fq-fh5bPV&wSQC?Fd~DwV|8L@H%7qBmfR<K%)5ml__7(p5%a8Ld_(6_Px_U`
z{r^EgTqrcK-2bEN5A1)p3wEKK|3G_Ls?%oh9_OcaM9}=+kI#Vvk{>muLzh=e*M346
z$|H&JKT_ZYLcpLNX0f=gWGVaDJwm5LciRYn;2AQ5$K06`QRVl7Y|MJ<L49D<fA-oC
z$>a{X*ds+;)nVB!Hq;#1CGfKa$mnQ^Xh)rIKB8L}dkz((l``OFDyg#=&rmGOUQjX9
zmjy>G*<-;%(R{oBScIf2cEoHk0^67)0=htWN^i%%i|)P%0nqTBThb!Gk0eislIST!
zFiL4(p(8#jb1m|_MWnN`YLs-Tijvi1a^Gres#vHGPzH1)y_JKJaiyF^bc#{AFohEc
zZCX~vjV40dF^XYlBch@Ie+c+r->7#9Slg(R9(?m9{RXtBn#>)BZ3Nn0@e$9Ls2dsq
zy2P3h8$((CJIens-=bsj)8zE?C-QOiNE;Zv(9)tvKBH<C5bz-3^Stv)BW>@9@xj@v
z_2N_*0aD)hpV9fPlkq(MmScS-|GC&omu%$&UI`!6i|1GhqC;CT;Asuw5UA&|d3>n2
z)A_}(b9-qpenNJew;M7}|3M>L!~|NH7I(~E&Q%)}W)bup3zv!!F|mYz=?Yns&$?Ti
zZQx9nbcJeOSx~2!jA-RRkbrG!5WHha{cWD0Xm}lPW3$~ZC$(~Y{z>c=s;uOS)N&RK
z4cUoL(iiYYRNmbiz`K_3+AIZom{+$Tr=Z>Zu{fr`C4WI~L=rLXCrjF=LF>7<DXYuT
ze<-dayem|})Jcf8R%f2GAQ1Qomb#AD<}*h@JR!3?>}|IZ^r;J}Q@$2Yd|`JvG@W&m
zpHoq?(niOKHXr~~_x4vez?J}dZI)4yTG1c!ZrbVJ9R`jzAc0nO5HZfV3?j@ux-Ue?
z1ql`(o?x-A+$YmY=TY<cvtaT<*B_A<wO{O@%rbLV9hV(rV8%-hM71k>aS{px*PbKQ
zHj8CME77zO%$wfk(<z4T24?3ncrh8_Qzxb^_<<+y+Q~5B;3JAT@7^(Fgw?5bE6tH{
zpSJ{0E`!-0zz{i-<Hh+=S<`<@w`p*BAlvZ9pkQboA)U7M8M$B2;-4DKhX(Ps7ciyA
zKsoqS+azr+D+qPB$Brr`Cz!IY?ikunjb-=Y?)R^!E$AR8mT2~3;|uRg0d5c4{sK0&
zETehq>eRf(Bgm|`>{bFb@k(M+N8|k8FJ#&9eO1;%;1X7PbI>i!=Bx=0wy*W3WjC>>
z$<a?7)dz(5qUi)GFHJi7@HAIf<a(!t(~pz{cZ=6_ExB2H>=DPlLwm3tO`w7{ldJVR
zKFz;}tZ8WFY*jjZ+Y`l){AaT_nWBOj!iep>N_CCeT2gBGC!&GDrWus3_4_?X=!fB6
zCPJb-@O-tJza#wqX`vd&m4_kI;NK$ZY}1&CTLu>1sED8~EVNVp4Knt`cNo(r%2qL;
z(BzYa-j&N;7x-k^{<6gT$2F3Q0^YV;@GKE0`ozBtL<vfxI+P!HG+eh1on<fG^qIpS
zZx^_k=Xlj(av03+EW{7(Eij{mMc2GTZ$JzNB<ss{b+C4-|5Kmb7ND9n?MI_x2}F43
zN9W;ZQ)^f0-<McdZ7K*$SB#3B1eZC)Y4$R7!>M9f&<)<+!&Pq--1mR2nE3N9^>QwE
zJCSGoS4(&-19?l~rZm)Q>I7NX-Gj4il6{2MI4XwXEJfC!;fyKviF5Pb7bIF~DUyl~
z@WaE+p^Aeuj`);fw3F~&#*4;j5tjFe9bA{8J=i%I6ATeLzP%N#V;BZP$&ZrbJnIIZ
zR7;T#N12YEkykfq#;|K<J-AL-MvB6(WHWmtI*t_my5t@a0b7h?fJL^Hx7*Y)3$2@(
z$748uxpepl)&MUvho1wLZl|8aT^|nc{D#U%4siPFT9xQruwjI}>C9KGI}Q2~0eR9r
zuqOeM>UBuzLLr00`bi=4mzAqS9e87wyPoc+JFlKqD`R7Qsj2cfatdmK(p8hk<v6?!
z2jjQrTd6cVdbpW6i)L|qJ5EUTviZmElX%qCnL&F;IP-SIv`FPxOj*?Xdkqr+L6Wy<
zHPb|>mWZ`N12d4nr`qodZ?>n@2$3*H|8zj*wF7CQyCntXeIQ&jORXE>F-~hK#!GVt
z*-tWZD<)Gv(gxoc`IRn9SNtFNUd+pC_=a<E-xL*pNg+6RJ7<c7dav$G+i7bN{kUFH
ziq?Oepv!KwLtEYAST!GG1UU)hSUt0K68w(-%n4qG`qkV=OU5@p)RXprc&Tgmw#TVh
zk^B)Wq(OS@0!<w^$1Ht^B3I+MWG*Hf;HJSJwL^`{E=evtmU=-vRVraKA_`I|z}kvr
zZ#<rV#JEPQFDgky9D4ZkQe&(5?X8niYPFjV9{ZjK<f;r5j~HKCaL@+$wWTVWH<2CJ
zbC+ZuD;i|lEXU=3kIrcsqs5M4<YmCMH=R?3+H71GhCM)C7wzp_#z-#bP`o0wio;ZR
zl8P)A=PxgCRR`<&1`mpEqiD>9SU<+q5uvS{mK<O#MYVXP;n@I=q+;EU@go&GC&!(Y
zt0K<4>Z8nU+RYy4K8znw&Ty4eH1&j$s1x{dz!J^N+s0@kpE|Z--~YCg%-p5u&{#4v
zRZK`}Hm2>M@I5SY)sEU`jg%HcS@}}SvxHIOfvQydWgX;xwR39|T&X@QoQb8XTYXzs
zQYrHcTtF@<`M3Aqx0rjEdcCy9P*sY_z1!M|#-|VoQ5UWY=}7`!sO&-*k&>i45D=|_
zGScD{AQ!Y4XA|+cE;vjz?WK`W7Hj8X_)HDV20e=Mt5C7SAY`EeJ_Fisq~*cZSN32@
zCT~a_4#|W7UwGz^l*I5}Q8R<jRO_PyroAuM)GpqhHBc0VPmbq4>{<V|5hQX1XQYUc
zHn%MD<+!vK=S+aY4!BMxuvZUbELvU*|61(p2<YAnQct&?^t7a*DQ&s^oqKoxvd<oh
zRxjw7csE%o%E~xdP8g9D*D<zv3;#QQTPq=GJLMUF1Z8>uG0?9X+(kD|!UR8oS4vSp
zpzS9sz`eQ!K=_kwS0phCA&WR#{iqsf42cjmB_q_)I{_{WYaaR&4|QptVGW}~s-eq~
zv7lUDIX7SATfxLV4T;0b(Y!n|@^$ZR$wfytt*xYHxQ0ed#Fr0(32hGqykYsR3f&%P
zb77TS^|^VLHjW;1Pw9^)=mkX<$K71{f4cP3OfMzbG4f+nY-#3<an;wZVg77qpWWl|
z_*0>@3<I=VB~ivS9ZhYUvm9v~R~z>02a8=kE;a6F%z0Hz2f^2;#6RZ$q(H^f9t1;z
zwKwGSD)B$7hBLmQWjJHC1f~{Uu7a03-$o?-S+dO4!YvJ-*+i6a6(6*Tf^H^@52q4?
zuD#XeqWDX`|1SDgC)fIxLYb)NZg}==xW`fI!T?dI+5lF0wEwL5DfjlR2}9w!cS!&%
zLgUG2B+r5|wswrtnnMwx!<RzlM^Vihiu3{Ed0}{DjGqLi!&%He25~|`S(yV@M@Y4Y
z3M?Ns-Pe8e=54{&URcL111U!cR6Na;<s8SF5eu2N-fH>plzWir17Y=jvRvnolMOm6
zY~V^6iASwSC}mY3Q@xxbG_P5oh^VWX-=_Bp=>eCP6}B_qP0qVNF1!EfNZf{ued)b|
zRR`bA!D&>-qJPCIi=e>SlCciJ(oPY}<`ro)?6B*8de+((6nR9C4}U%Tb9AGZ+>9g?
zwK#5)+Hk-m^`auv6LmaQNw!MrtFD;t3FPaVXv+Wx4^vcSf6;V3p;U&CKVmI>Cx@(i
z&&hv4l}Qnaf<$Xh*Z4c*N^4uYxm8|NJFTY?x}@JxA=^r)@?U+{VW35;6RF^4cSiP4
zW1-)4)jsPsUp^FPB<#SyFPV+aV^=q9Ou~SgB7pxS#&Zq{+Q?PfqAS#HgV+Pt1v+$9
zF+bZL@~OWPi9RG9JEIs{j9Ms%q`7l$-C}6-!^L*sc!ve=aT12i9K}F!#j&P!Qv6fu
zjC0YXXWb*lM8zxviK&XdjjsUi`D4_1yNt|~P3$Fwmfz&5^d_y{B6~3}Q)mTxHuzuo
zf(-v2hXh-}rsGG{XM>Uo=&Ag~0kem!5PSyxQtAr1tYe!^MX@ZBxADo47(@OHuAOuc
z5M0gR7}K_k>j=#!=8?60EeLqy$S7Rm)uH=_!W5<<9i9F>Q^Pz=^a?dMxZ${AA=j&d
zjO$=fc%vFrCaVqTRgUH_j;BExZTE-B61ENkSv2sQAs_2ciiV79r~|Jipc2wu+2o%d
z!=AesN4zEw^%GGml>Je611urQwhg$UC!XTyTz#ptk!fj_dDyVcziRR8uS%jf5UMjg
zJVRPDwL$olI2H=Zv(_vftJV3nn9QzL5-3P*!I*wyI*$1}(192a@n1c)Qej)Y3<XQ4
zTZG6sWt?27FDl$>xYMBv5CTTrQUOKm0*=`qYocx@-fP&BpY%|DVU4A4*#K`;FXozC
zLrH`X$c0`txEkcuDtCk^53#L^n$@L8N;=z`2ZS$BbWb&$h-i$nMAeD#MZ`Qs)2>TP
zV$GyO%~P<uolx2$_)>bGc7*V~i(?B?J|laVIxvsEo)d71l1dB%UkEmr$JyNZ>Nc}h
z?T-F)?w}xBf0Tj=oBBZZ5wf$!Dtp199mG<M-}*HC4-7DeY9{%<wXJ@jvGT9ubEPu6
zO5!iO+Ywlh#^7ZNx&7qcDdQR6^p@gr5Ut^w`t@Nw)a`vT2fdrP-2fx|y5bC152-l(
z2X+)i3XeReDMoSzu&DK~<mj-~fH3!LmwII{?E1XRI<nHWc}<o^D?%>#SK!hS8RB7~
z{)1Q$Ls5F^ygnlF@o_yKU1168ces5_0C}D=Tah9K*O*i`oFkZ*Yg?LS`_>Z5o5krX
z*eygoR^Lvpleh%Kyuv)<Px}+fq86M#4Zlx<Zfo;fpENI|fT`0PMH`w85FdpWSDSWq
ze`|dhwGWX(>mQPs!IR7%(`1tiTx3|`ncX43xx1N+x%yL}+<U$*5z3<aX>*GYRWAd#
zFCJnhx>zG{Mr9~TzI0IhUX4GNV#gMh-g&2uO=TMGG#-3P`AvKZZ@FvM7#gmNA|Id+
zs#!6Qn;00KfZa1A@Qhsl`~z5-IE`>J|Mu7ZMz!x;F=n1gBqyF5X+kIz!43KEUlFQj
z$H_;?fxKIxS5HEBlNHLYzD3;Kns!D<2a1UP*iEh(U4pc3Ozz96dl~_*O+NdRehUto
ztbvM2zh)4s801nG19LF3s|+^Ex3#8h3myOdd!pPG2F98cc_m^44X(2K?=NzR7<I}0
zt`3G*wTyalc1z^v<GFC{-^0C|CD-vr1}nI4+C+1iYuPuE4F75t;!ZibR;^;3r<*7G
zgtMBUB#e&{mu)X8-7eQxUKxBgfUOPAS;(zlZThns&$Z&@m3|T$mJ7B*bP(fMLy&vD
zeR;B60{SyW@Lix*5h4)Qsj$d9vr)}SGH(MB3sS3aB2c-*@s6tQ-4l(rSI%zq?tzjN
z*~o5Q$WUh*W$*}X)I}l$v?Ncq;A}A1{BN~KJ?fVN0V+SWB<4s?h;%3Ka5{eO$G%yU
zq(QXFWga2P2ieT29X)7tibz9zB%n@Ct1m650)9HtoEBg%=0O|<ep8xJtrFz?=7Q|{
zv&QMf8C1AM?}~y~`y8AI>i3Q+=}49~N)uGg#lN*L`3l51K?F>6PyZU0ex!(w-|>=$
z*UX^WJNyIhwV5g_U(eW1>N*Jv;(op8ApKCP*iz;;nF$p#|MGR&6-A_>%x^KTs*aI7
z0*u`emL76Ln_SsQ%8VaK5j+$8iA9Vq=ck&O1aiVm>mv)a8KubScehrdWeJD1I*D<p
z6=x2qKUQ}${14+t@wSvRs7s%skd|scqI0LeilGm;_tWNQCjSVJ>rww=MrnvD5Mk}X
zhE=K-H;s>w6p#I9R2i<i@G`xMeSGS<3e-fZ5<oq}O}Z;h--5hF(T@%uALD-@lE_w#
zMY7lsn`I{vu1QDV22unJBcEL*tCw<W5q*VSnU%Imnyim{vQLmMQ(db5q(!uOEX&sx
zH&Aki0nckCjba4D=Y=~<!Krnv+C-_aoa+Is#Q(h*9bYE$mWG_+uO`40yejZB0bHGm
z|FYp0h$B85K|7v3U`tlleCBYnRMfgjQY4*~wUENNaNG($G2}~!e^UnC6aE&-Se{6r
zDJ;oWttFGETDxDZKO3g1jWzo4bu>o7J-Nq$LE$)DHdMOhgV-%)80(alWYiv=?jmtS
ztqNI3j7<WL=Uh~wcBUr?B8z=ffw}y0;rj4UR4Pl6K0*1s6&{MFjjEyqg?|N9N<Y0B
z6CWu*i?(yYt#GQKY<>Xrf-aGQyaRjAUxs0ibvC0*bUo*sM&R@^m&8f!e_P^6S>sz?
z9rcz@kmBr^=LT00P)ek+r3OH;7Jx|a3>I!+M9L%WZngQ80JEH!{*5IGNKw9GT0*hR
z`6m3%{+<|j9N{Jk5wPAMe7GaJCQecuuVY`$AJRQBqCe}AxDSy6lD5TrFXu!D5*F3-
zD#|j)a||~URbqL2RGXz$jnnj$$J(UpCNKINoxd24;n}tchATsV`LHDr2KsOP`_I=C
zB<(E=#Od!X(zS&p2n)Oj!5xc7yn=`ATa7;q%8-Li@c-n8n9{wy7csejVX4*Y+#aGE
zQ|vJ8A0}h7!3Tk=OZgD4aS;*7Lc#~@zRe4D#ZI*{8iK(8B!O6<|0f9q{of>zo0FTk
zSWpbiO$#i3;Gx{FvJt<%O(vV~6Ju@tfc2oQ1w~D!o9eh9cfm-L1caA)^0fSj;mR{;
z!cv;@5nYV!;^vl%`iFw5x)0|HI(k2zm7xqKC!-gjlw3;Pgc}PnL$wX+djm?WX%bq<
zoJh*xB8?cFxuBoKrHRH9(clyQ*!&yf!QnziP4GlE*?DFoNVr)ZC+UYPK7k_1N+(Qx
zDBM0Ks6z8I96t9Si;;UfC2Os4qaq%<%*sK6iuYLLIxDVXyeT^`QW*0bXzU(p|NIII
zy*obYMz6p7G_%?Dr<GvIyIGue4W9oXIz)@UATY?lzDqGcX9|cJdAeRVo4Ee(|G)qB
zs7k1aNaLt2h?avRtZ|ws?OTmdqJb7t{?{bgyu!*lXm8u*Rr9YXYHr0KlQlY)32Bs^
zrCQg5BY`ZCnDfCFI$1VGC!FEOknhc2)9E~P_@agm`RW{gHWuBo;gRIDlEDBpNra5j
zh*N`{N1{th4W|wH9_`g6;>*uopw(;G8U*b-I4#<b|E~qM-$gt4FSDx-HW$VMnOqAk
z{ag%6-g6_FEEYIGE>)H%LE~Q_$sKI6EoVFI9GcLJ!OO}W^Mn|8`deIOl&%_mZxY$o
z%wFEyYX<uoGQBuf^74%8xo?A&f=%v)5ZK4Tm}=e+KN<sLL*z}sl2SPiP-U8fw}TOT
zW$fGK!}MySSKQ7moVsh|+J329h~c;G!82dg%$;L<46qk+W#`{|K`5y+)zKQ#|Kn+I
zTGmN4EnP}4dy^`DE3+H7#aTd5^(@<m0XIR*ffQqeK5|gRX8f&9r^n{A@MwCUEkYT1
zmS!3XpDm2Un~Mws&e@LyoG@bSL9etEQnu*!SLW-goFxQBhYc5uEnb#?=0$}!JY#F&
z2qw#F)WxTA50Wu7+N`QHE8-h|RGhi6jTvEj`ht){cBNyu*bv@Z=2I%hkm3*2KPObb
zj-W)-{Em6JGP@x8nIyFE$p3}Eyd>y6S~MNBq%QZ;8rn101ILgJ(0e9elIfU)j;>Mv
z$-6wi>H)v7Q7-3}Ka_nI_C6@EYMFRi8+cXvyOfBas{jE(l33G7Br3T(QaRt_spYIr
z?N}2nePS3#T^N9|VMim2y|yn9KlJOHx*Vq(Mi21>K_nQ8VcqU~_eNHam<n>wa>q`$
zQu){BOY<poSgIC35S*C>#e8aoE2i^~^wfS%ynwiue5A5(dz4-GBU0CajuYED<#-P(
z8{Ejix~AKgw|#W|#crO0wpSt99(mI35g$F+b|#@OID-1!>@4|ulUbMJw21_Ce(1~O
z=X>%WJ#5XN-Ybe5DQqt`Ymxf}As+pa=ppG%NqaQk7gp1&z#k<lh45ytj_e{H1dwZe
z{Z?qS0SU1nwz4DW47ouuSEW|oHofM8`toS~pL+x&ho762sw2NAZ5!4@9Y+c37>d`F
z!Td2Coc%%+DjV3_e~WniuK;fkknlvN`q{PgR|r{d<`CedIIuKXGi^pt7c^~fW7>cW
zl#G#)XsRm1#-MWoYQblJD5~y6rL16hOAFP^007X5_ldassfF*{!`MsZ62k8hps|WM
zPgaJ1eF4lQS+&G~`DAp10khqki&j)C!noDeUffPVwA&+E&L>!bi^R!T%@)jB5i396
z{qU#dJo4`A7I%3zm}Wh)sOEXq)Y>Q3x!J6At$u#?=dEqxfiVPs-|j2WNaNsB-w_8?
z{mJsb53jKnGoH&ib1|Qn&~d=U%?zl#D7j@8e1Y4V<KYYAVtCxB(Z@^-&$&c;G>9*~
ziG&uZN~Z)>hGK+^%U|$E&NU-eJ8xpn?Pbwx<Y0;R>Q?S{;HnTT&1aDg^Aj|WqKRIJ
z>KKY@irSpt?G9Cc<Fu$IJkm6eFTK<`5?H%&|9=gt7A^1U78Pna%9LNL!9jo<oaA(^
z{5@gj68d`94^8duDF=UPij9k1BSpec2&#FT;P(3dZxN*lylb)g{}n^ETj-iaUyZYy
z;{ih~aQTv!suS_|;BG#8UYQzzH6hw{);BM<o<LQr*+a5_$v9HMK*s!fzdRKt+j_1N
z{xxNx$p8~<CH*r$xwsItg5v(<=wFL!Ke$ZL?bT5MO};0`P-VIalLUGCu``DPq}Y(-
z#F9fsE{#_C>r!{Ua@CDHcfdB<855x+uh39Tu%?GGE`?g~3@X^FQ1D(?X-0(&JfIXX
zq9Dx3L8)ecMIKHhxg$>m2j6H1Y9h1mvtRd5cBqTPvD2kd$t5nXfxvjCy0g`4{)Ums
zMoM5w>`eq<<%dU#nj|Y0(yF5TU<G?=OY(J$J*z61C0lgB88M}HGW;_SycW7WW*h%3
z$(g88&OAOG97<d3{C8od-&Qnc3vD+(ZrERg3maj76?TOlOH$$LBD=WDE9{+V>t?7P
zRz5{LRW+tmYy-h#TOCa3$Xf!xD1cPHI(={Y#dJu#Jb3jYv%dv<EfoN;C}Ve6260)R
zFw;ZW=L?t`19Ejyq>bCX{LnS@wrkV2$O+-^DP@!!Qa=eI)>vJ`vXKGgQwD#3Hu%7a
z!hzp^O0|!Od=IT^mt|S<CN|Z8`W(r1qv^{c==Fj;xlV1ywQ(ThFU211zI>H>=fvhU
zk2A%u0+$Xu^9K?@J&J-pI~%+nse6Xu0)%YlqBl3sO1o1g+GIjQoUV;>_7!t%ec-O-
z_xIv$E{Zpx%!IUQ-dxTJ_M`hVL}pe6O$_sY$|({WSAIJXVPX+fg>kw?Gr9&`q~<iW
ze)?&@wL}+DxzvWgrPBjbB8TGF>ymo!S0fIq%s;N!frOLX1f6@T{SZ(m?pFy|-DWXJ
zYWF2YiLAxU;xryc-RT6(6y2-aB<O^|eoo6P(K0z_o>u@1{wRL)06O=5<dy7zX6XWd
zTX&$bKFXljSwN;%Yk*>AkOldP^a;AE7E>yi;&VdqgH8E?A#}ije2K&;t1coh;-K>H
zf)`B;a(lu;rI5V-HrG#}rDyhaqj);{09EcD;n6LoJfphTmX$jvhmV`CvQ~$~n~Iyq
zaKkcL(Z5rb;!<-L|4$FBoPJxIxtG{~P*7ktk3O67&-f<(39kph7^B=0JwMFFLyC~@
zH6T%$8Deq>=vZ3##O3)3%&Y{*VxBwZf@CkhgPLii^T}8jXUf`IrgPJsVE5XC(od4T
z_J>l`_Kg!);6fZeY@AT5KM(FlG^&W&oO8>iqN}Z05I#?lv(?*e*I{?Eh6HwhBnGQt
z`b{3u$g~G;A+iHfa}IzUzSU8WX)62-K-)eG*eNCmdlIuSLZ_ZrDX|Wfokcy*XQ=5m
z3Yz#TusjRRCCVEFoDrh^H<R&?BXV#{MfwEDf{Wm4S-mQ=^eU@AE~yP+hocsw3>@jH
zCgKjiR1&F|N3~5aJm}#iLm?@Ds_f|gfBV=klmV7q%?xF2CYg+V;K@`9O%9X6ivxL0
zj<2&-xz}$;=9Ov<yQF-8kj)~v|J1}chPQ*5yflLr>*??j4EEXp>3Q9e*p>I&X#nM&
z9kvMaEvD=4{e(EnJ-ie5&=L9Q;c&I!#GofsE&1f*n37S3!y^Nblq+z5O{<7><E7C-
zXT;Yf%DSt-bP1W0t6!xP0Sz~pq*k*no8_F;n|1YC*d|I)TsRXOe!<ckx}nrBr5>!w
zW&W0ct0arZh4}EagdsF5p-E_>rGsX+=^BxkN<~Ad6fHg^PfVwT22)w(C6+&K>0Rcx
zph7@KUA^_?$8pZrf&9IHWfU;<Fd%BT+s}`4g5MAOF$v*zxt9lL2`<D$eI4`oiZImW
zZWAfSx5sR)%e28km`hD-MtgdWk|QUA^w^4Dhh<ly5Wk^K3^W9ULOd#6wq2L7IBLPq
zM-0l>@=o?8fFwEp53ZjuDRO-fJXbz~)j@4IolVZA?wQYmyTcQI?Xa%*^d9+5A?s_f
z8y?|I=KI4SR;30E;mh~8OAVPf$$jEX^0UfN&-n^0^rS-x63P)2+TNuU2_n?d=XBiy
zoDoQrMyjsP&QlNNV9*4Q+8~I=?jv(LfmGr&iSw91hj83D)V(l5BP950BHQ+(>`pP*
zbk8iSOS$qo+stl%Mp`Omzahi{I4BdHgS5Ntwsl_iJMn>wUA}$UY^)lTy~@hh?$FXT
z-s+m*-0;yel5w>=`_!@#Xl%IT9*q(&{$kfACS(b(T|Siw=B7G(>J~a>Po}G~-2BbQ
z0;-5yACeoSPnkp<G43~jsvyZdaWp4Ws6)`3WSkA3OSe{ko}^_t5Q%}Q%K6mC{*%Bm
zzUm?$*j(6F8ugtN+FpNs+T#37dU(;tS5A<P{>BgmoOpdji~H!fwq6=>zfP~~6Z$p*
zH-^O3ahaL#g2$l4+C)GaG7Y;cLSf4s^xA5*I`#ya+6}i>b)}r^You*3rH8vfwW(=U
zNz=<|-&;3-_=$WT>6Z{%NLT!_)K8+9p}J-LdZt7h(%l0eucNt<1(mf>P+Op|J0dtE
z;6TL+$Ph|bIl?}oj#WYBzfYE5A%s7t@BP<sz`Wttw@%~c7(^>mNFmQEw7vb_*hGbq
zRKr{MUQz*ya%RXNdxd>bFfx)@GsME|7HZyTES=hahGThA@nduW5W)sGh$1x<1Ybf)
z3g}6Uv-D^I$NZ}k?;Kgvz{MWwm0rx>z+B`&vO;`1?vgKUV$qfbrJGvh4V5eUBZV5)
zP^$KN8AGwUJ<kOBS^znQh2IUv+!3shWMGRWTejVpz#O=p*qg)bBY95uvK>ca>;2Wo
z;u!OP?vpE-3alwVtU{>ZecpkFR5Tt*Zi%H!Fy>#4AGehQulOa;Two+Pd$<Atcw1-d
z)9<>TU=;LROi{aq%J(B(`|mfpnq3rO^_)rdAuc@aatZXXb?t>t#P&wt9(!AFesoJf
z?^+VNm6r$lMI$koHXZ|4h7+rBEy;b>ij3`lERk;?rG)u`)>zZWDi5RPJUv4+jH81<
zGuu#Fn5Y;AjHB8uFsrZ-%CAqW$h;m@j?|n`5kZZ>*&uF9JkQADMkd$YqY?4~m;F4B
zMy;fbp5kvB&^06%FU+3UXujbOOZ^7}mjS^O_XQ#;8OifQd-&PLEL#&tVbJExuB^X*
z@n|MOjt;wm+RC;*QH7fv`Apt$hAL9UIwajtWLujJP%TmQXiNjFEYqXA%cY#&-)B(B
zrk#@ZMLANg%omz}Ov=CLC5TxqGpB3@Tp#TaqRXUgtZ-ROtSDg1$)ZEvO!3%Yg7SGa
zUl<W9E}b?t4qkrgAc5h8(c|}JX=F=(pm-T}K$|*d-LB`V!F_b-PKO7HxfER|>y@SK
zO6>DqWadm%eRncLZ=>^KBt18Rc4*k0kRnR>Jfd8SIFt(sCf-TaGKHi|(Ab1V8rq9j
z*=-aZM-jx5ia>JC8Cy@0Wr}KDaGvZ>CgTGmn#lCW@IZ(!vM}2?#+9qd{cV4L(YyW&
zJBhn$xqiBrhLKv|4G%}<i{wH+r3m7~t%}yP^J(53Z0YL|Tlg5M*20Q4kKNsRfP&Ff
ztdA)<Wlx$qT4ep5ccA6+Pti;5YCXn+(<cp-{w)u69f-d<N8y4wN|_7u^Q^z6bSR6z
zvr7NpQ%+|GF@a{EPBT4uuL#e7GnpGW%U4)DxVFaas1Vq1Inc)@#ewrEykHg*x?(w0
zZ<<QEl+Rp-GiO5~L^V^7ge}GTi(R@r)G<TvZ@$AkUce`|O&q$e04K|BM;#FR3dpwb
zYI-3>EyL39MiDxOa4BwhJ7GC;hj(=|^RO|Rs~T~lu)$~)&LvZnQC{eOiLbkBO%8Y0
zNci&?(za1apd49%2jsHn)9mOe1KFW)<VwonKvF)#Q<`BWn|7{MpE0nY?p<jW8ymY5
zGx|1~>*tT|NvGa!ehE`_^R0j0m!F{4+t>ySyn57LNwv8(dz{k8OqjfOD!p=3fO&$k
zIO-r~6gzf4Heao$nuX?n`;h)UAg27ph0rt>tG?wCjB}2*qs2;6;98|`dPa~o#tcDn
zDiA1z3+WepBR};M%vb3QHH-LvzuRUP(Car>z`s`}oD|&yqSucR<G^cg%)g0Ex>&U%
z=hcRpAc4j?E=i^OJpaH6sp^uA9BI3=eAyz@X9m(ZoolEF_D0r!JebH%F-`6_`h?2<
zR9yoRD)!W)q}vjuOhA*Z_UgROyx~(bW#Iq1N%tSA_Vsewl0AUjo_5FVwg$yokkaM%
z<OL@@%PKCv(U~?N^m-PE0th6kpL%LiBtI8MaAOXRHL&Ph!4{^I0jvn1QZOIsnGzhu
z2p#98OKZ8`5=cjX>>o0;XzIdUmi(;zd7p#X_}{=4LSCp=4SSs7UNz#H45dU4lexOn
z3je`hZa-yr<)(a1&)RmhE0aw`Klqv4EE=vpeMMx8%H6L<VMOV?JoC>zc+pQdO^5v5
zEmS=jE4^Oz*j?%5rHPRW+Yp+!eZ!kPKXWXSh8><lM4u6VP?zi<StiqSo)3J?o%h2I
zsty?KU2SPHd-NDVT2>ky4i?-c)7`#FMSXC#=lFdG-C}$;h7_1s%9wgVi+gMATta03
zry)_qnStosRd0OiOqebT=_K3-MEZF9IA01VVVFCTA-p|~3#JD|nlGnNx&iY|dVf?j
z#@MhHaxLjWr3fgvl9Rr<8mNU(H@=9+4Zc!AOBivp_Z^@B2FjMb_9tuwYC0{dMJnK2
YVQu*TZ8nl?f%`zS*L1OeLEkX&JxSZWhyVZp

delta 28
hcmZqK#I&TDk;}!`kpTo87$#a7O{|gH{LazO5ddxw2oeAQ

diff --git a/amd-ucode/microcode_amd_fam19h.bin.asc b/amd-ucode/microcode_amd_fam19h.bin.asc
index a32b4d61..8cff9013 100644
--- a/amd-ucode/microcode_amd_fam19h.bin.asc
+++ b/amd-ucode/microcode_amd_fam19h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmS3F00ACgkQ5L5TOfMo
-rnNEhQgAizSV8IFpvaYNytaJKLA4uevrZneGPV4czjCXnnj1yHpfQmCTyZQnoLnx
-7gyzf7K5271zO51FBQ5z2Nm48a3XPUhMbQLNP4BZdekLiA3bRpMtSyHct6zD0ULm
-xaFaOQ7MR1tGADhlon1bDvtnOuixUhwrZhEIlR9MzQAzERKDMOAVTbxn9ZhMfYiT
-LhA791Blyyi+6Z9uh7BpaA8l8uvoxt+uuvlBTjQMR3ER/TEjgcsoy+XhhK4QKS0V
-wJCtcDle/3pF+N6SAFWiXbNZ+P8p19afhcYddDl97xtpzA6/8b20a2eHkrqnu/Ds
-jTozF9kmhiifYMYpXtXgSOwI3GRZbQ==
-=t+j1
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmTEYrcACgkQ5L5TOfMo
+rnN4IQf/QKbOezXZ4OYzaPANvsZQEAzLNfuylC/aQMwrPaO7daz5/zmCN4HU5XkH
+dDT8DYfPg+fQHIgxAw0/L24xPOm5Op/QuLVDyDqVr4qvL8+65eeI+JqxD/wXMXYN
+V34kkLM2p8iuyY1Nc8IDLXu4X75KGNPbKZlMRKMU3Pr7ai5O4ihmiAM+N6qv1KEJ
+YToNN6vrg0qt1cv0SLM8sa4e7L1+oblUrg/o0FViYE8pxsU3ZRRVSJMUg+lKjvl/
+1ZPGKOdD80fcNJ+ItYGHNNs3eCc3WgW7Kc/E668eH75Yu9Zt7ewWZX8Sg/mygleY
+OzMwhbPJg4bF4zm7C/Pku7i1T2Omcg==
+=km2X
 -----END PGP SIGNATURE-----
-- 
2.25.1

