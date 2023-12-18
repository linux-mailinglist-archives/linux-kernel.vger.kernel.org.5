Return-Path: <linux-kernel+bounces-3113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B76816792
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373AC1F21B56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CF101F8;
	Mon, 18 Dec 2023 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="PbudoPQx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38548F9DC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.9.90])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 62EDF10B1DA81
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:40:52 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.176.220])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id AD04A10000D15;
	Mon, 18 Dec 2023 07:40:44 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702885244.389000
X-TM-MAIL-UUID: 7319bebd-f98c-4a63-9f7f-b6213c472697
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 5F2B910000E3D;
	Mon, 18 Dec 2023 07:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKeIKqsSVh1KQl9IiKqrReUw5Y1LM/xVDYU/Kq7FUlyuKvp37jh17k87RUAYo+q7lX5p6lHceS9U+r0kF+9W3X01yumsFNYC2owxUCoj3i+BC9yLwmXBKCJSpS7K+w2IW+mpQP/CugZWiwoHCtYXb5HYt5d1QOfi4H3r45wbuPNvi/TMA5Fq5uBLvn9AgKFSKQAqfXfy2NSl0d2DvmRSgS8adzgjyW/IG4mDoEPHD57cW49Br0vw/ppYiPZZneW8flcZMyCXKFazVVA7Dz0R36mEibLeSbAFNY5fSwvcBOWaGXXHDeGwe41wJPjYYzFVkOBOSO8qy6iD9jEh7J5qpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpOCaZgwPahm/fdWdeYRxx7ypc4rKVKfdFAHasjtZ8s=;
 b=YN6JNtJa6Gisoj2i0s5Flu6rw3QzhUDedPl30LcVgebhHLHaYjgTS+bY9TbQr/maPRKHFaABH6vbAlKuIKZgNWkn79ROID3lyAbR2GKm235ifYeLYsPs+v2v8C1oz8d/bWbohHVhzORUUgaUPGEphXGQB7rBkb8VLNsUmRhYnyf3zo4ehnZwhF6BmFedHv+mZAgNbXKO8ZwoIrt++qLfildCEyAIqRFILRoJvZPt17qBPQPjkjzosCS1gYxweLNNOgJBgkqxRCl1btHJBdfecFtYs1Z8j+xi8W5hpztUeLVtrj1S5QDw7MIdbPKbcJHrqo7PEt5rqKL8THToCDChKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=google.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Peter Hilber <peter.hilber@opensynergy.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: [RFC PATCH v3 1/7] timekeeping: Fix cross-timestamp interpolation on counter wrap
Date: Mon, 18 Dec 2023 08:38:39 +0100
Message-Id: <20231218073849.35294-2-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231218073849.35294-1-peter.hilber@opensynergy.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT008:EE_|FR3P281MB1645:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 087fe7dc-401e-4737-4e77-08dbff9ca3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1GmSfGM7XOHIK2W85J11VPTWAqnRZAb0hCWkHp5eha010iH7kW9BcPmPZtQrmB6gD//z4omR7PQrDPWO3WHJwZ5RWe2x23fRBMzDOkqJMuSEp5/s9ZQHT4+ul469N7ak8aQWzkXRg81moem2anbDvKEr2yzOJD8HFs7zOOmuOn3wCxmTYqUD8A4NxVkZWMcg0UeVBMJ9FzaXAdUjL2GdQDXeTLyZqQQKAvzMrShoF1+x/ccvzyW1w/LdGawYBchDABYKOyU0zVFym+HK38FgFfd8o+5J8puoXECn8LCbRpToYbda7MZySDiEJmUasqRmUd9oB87AhCzsI2YPEp+U7RpYE8koWkHR45JN3dUtbOERqC1GWzwCc6jlBeZprVb3d5svy7gn5HXoeOkNSYsZy00kEsE5BjY6draB/Yk5yaS0gTWiS5/Lu0n/00fijZdrWDi2OA8BBGtzQcnp9vgjot3rKCW/A6o0MWnoq+SG1WN0tqF+EelehCdCakYHY0wJsJHLfB1M1snkmywpe1ZOe1AHXzLLe3IC/oZlQpLzmvSas/lvdYFOUC4fdcuxR+GWCFSTAGlZeze9kGIkgc2JiSV/0xAXCVAR7oXOB/hkq0/auTvcJ62fxUNZ9id1xTrDjzVwGiRjMjpeEnsYyWcipGxBE4ECgPz3KroudMm4QIeMB5FVdyx+O0VRguktWamwVBKHtGACID/2uvCKI1EVLnHBs8YS7S1Jz7g2Ig5IfU5UytjKOpvMXy6Vpvy0y4hB4dZol1nv57mSs3Vv04vD9Q==
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(346002)(39830400003)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(36840700001)(83380400001)(336012)(47076005)(1076003)(2616005)(36860700001)(316002)(26005)(4326008)(8936002)(5660300002)(44832011)(41300700001)(4744005)(2906002)(478600001)(70206006)(8676002)(42186006)(54906003)(6916009)(70586007)(36756003)(81166007)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:40:43.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 087fe7dc-401e-4737-4e77-08dbff9ca3d4
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1645
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28064.005
X-TMASE-Result: 10--3.038700-4.000000
X-TMASE-MatchedRID: vveLpsopuKu6TyUO/xKZhTakEkBtr136rutCeVh17xk7dRmDCUrvToyD
	IPOAt5xjKy3tE1HfkQHDxsdOfchH340cVCEiK1Pf0pUa1RtpyoMqq8hD1DGRIIloy91GB/ZEZSL
	4AKI4WH7m9Tc/GgfFJwFtWueZlMH03IFzQVLcaPdCPQBD3xA/3aODSWu0oxbK6gfKtA7Yhlrtmy
	EvxwC5ZFJxK/8gkcZzWa6vTkKxwrI7AFczfjr/7B2U/axB/TLSZg2qO/0BslMgcB+ImoL5a58mJ
	NfsSlkN5p04fCrux4g=
X-TMASE-XGENCLOUD: 51bae1fc-2e60-4c2b-9b45-ff59488cf4c5-0-0-200-0
X-TM-Deliver-Signature: E16FEFEA6210024852D0EE0425D7112E
X-TM-Addin-Auth: ZPVWLL62/fzzzd0bATplIpZhl03WZCSHU20WzbaPASPU5j/ThOZtcJHMfvd
	F4VlYOHPLYZqQi7TvzL4NrS7LCs3yv2sM8UE5rN5Ac92EROWYbOtUqHdu6kkCZQCCrNe5IOteXs
	0TsiMpNtZq0Ss3rW8UGz0BCY0M8mQVeow4zvVEgzGpFsj/Omm2GuIViGy8LhHAdTYtDG5ynMNlm
	8Z4GpL/MoZew3CtcFgKMzMwcy2L0gILrGfTSLeGx31MxKElm+4aUsZDG3tP8dpBQ57pj1DRdJ1W
	HoT+g2Hsyy5x+OY=.O9VHbA09UEFmyI6WFOXuvj8vpZtKIrPARbfEDNoK0mioq3+d3qAKIIzdWr
	NW5cs2rEj9gxl99HYSwSipOaGrN/WQmRV9VTW/2CDsF23C5VdZ9KlADDPRi/AsAVZAC0eeNBf2d
	qx3sTCpmJph2+X1Xnua0cYDCbuPwJ5qwEUhUgLu3kbprr6/m2p5LKA60B5j6uXUItDahSnmxi6Z
	OFsR7ASzRRN14Lj11FnwFDHmq7m1Bd0r7j6RkEp9eQARyqb0SajOIqYlUBGsoX1IptB56q8sOia
	saa7TnKjeTRRQMtgphhyUoLIq+rxJxDrndVSvm9WTSN7SIS7WTNXXNcP+Uw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1702885244;
	bh=hUtsQVX0BvNcE4vhtfv+v3MQv6zXnNikIBucovKIXa4=; l=1035;
	h=From:To:Date;
	b=PbudoPQxf6xth7tuhoEt7XigszKLgVrXdPxemE63cX/xSEJ+DUzSTqfTyWztxASUe
	 nInMvkdXEAK+Wa2uQHXrtCDM0SUW6bleh6FukQYNKTql73+GonlVJsf4AWfsTF+RTt
	 DazzSURXix0/mNL+GQq+GsNwH6gHoMr7cHjcVylCp24GDoDjB6uA/hw5b4dY8SZBdN
	 B1NgSp0LkPKSPQ9kTTC0cyIzaqEnNmED4SejKkSitZDYenad4hZtS84+MTrMa+akLW
	 4IXz1+dTpV+uFdCm3uQ4JW5GLI32DlAquwCsuCyebK2rCYiVyoPpJ7NrPE16k17+m4
	 L1Legpd4l7JJg==

cycle_between() decides whether get_device_system_crosststamp() will
interpolate for older counter readings.

cycle_between() yields wrong results for a counter wrap-around where after
< before < test, and for the case after < test < before.

Fix the comparison logic.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Acked-by: John Stultz <jstultz@google.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0ff065c5d25b..08a3d0052baa 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1186,7 +1186,7 @@ static bool cycle_between(u64 before, u64 test, u64 after)
 {
 	if (test > before && test < after)
 		return true;
-	if (test < before && before > after)
+	if (before > after && (test > before || test < after))
 		return true;
 	return false;
 }
-- 
2.40.1


