Return-Path: <linux-kernel+bounces-22994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C44382A62A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4241A1C22949
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B60EBB;
	Thu, 11 Jan 2024 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BqyU0qhJ"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCDA3C;
	Thu, 11 Jan 2024 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpWSt4SwHxcDeuckkptgfDs8w8mowkohyetY9Ft4NC1et6qaUSyHsKpyN3T9c4/7L88MkcqE8BdVpiA5CmvOIyMKZ+q+rvS3L9jJHJ2AvPBkiz91hZLfrxjgKRb6QRNnDYmmMq/9MUTYggkY53BxpR4HOs5N4PwVFujVnyFCpaE1bwTv4EWgbR9xy8TD7RTEQzz6jyvro3ud9cm7zrea8/yPht+qmethnRXQElR1aL6tJxo+/Yh/NK3s1U5rO2udMZK9oOAH9DNMHV66xEY0nG9SXZHIcNnHlnVdjbrTfvJOSH2r12hQkVpRh4Rgscfr/XBXOmvGdyfb7SH84/v9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ylx3wu9vzmo+4ASDYAi8wfwLP3K1yoR0XIIzNWxAyS0=;
 b=fbIUdjC9EGOAExLhLxCCzcIj6GAVbpjCW602yPe4KoxsNiNoop708kxkHB61AEm2bPvIRxzbaN3u9mKLAs/DGuOF+c2IE3IqCEjQvx4afgpAUvCdm/bRkAazRc43JmHaMqKHNALlDg6WVHZWmN0JxAxx99PyxYw9FGTDI5QTEimECM+x33HjjSXvx0DjlbLHlA+O8jpds9Dls/wq/aQnBUW7Rc2eRiyjq4kaPC5W1CD/v+srVW48LW9t6frm3at05eKz5vCAH44VxiavCKJ7gEgbfTVY8u8RMwkEiX0EAedrZ0aJL09tzapIEe5Wssxlyrwa1pPqguHKp8UD95u95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ylx3wu9vzmo+4ASDYAi8wfwLP3K1yoR0XIIzNWxAyS0=;
 b=BqyU0qhJaDmUZYX0pLJxO8dokOQpbyW47Y2Onoo5BaJWPYJJESA/wfkiIwpIbLZnQ26D5atfNLgAMbGTN0v3isufMDR1643zHQTharYtjWHtEMbNBQ7KAVGWX59GarxXnKluZxdCYYlZ3SeqWRKRPKeUJ0IEv7gqoEeoP5ndwh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by AM9PR04MB8860.eurprd04.prod.outlook.com (2603:10a6:20b:40b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 02:52:51 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::2a3c:9a90:b09f:293c]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::2a3c:9a90:b09f:293c%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 02:52:51 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: perex@perex.cz,
	tiwai@suse.com,
	ivan.orlov0322@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH] ALSA: aloop: Introduce a function to get if access is interleaved mode
Date: Thu, 11 Jan 2024 11:52:19 +0900
Message-ID: <20240111025219.2678764-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|AM9PR04MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a31e948-c4d9-4fe7-1045-08dc125066f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QSXzuI7Bvk5fMteMW00hJhYJzvFPC5AS1jLU9Oyod+JIwOaMcpOgKi1rYK0FJmxha0vrxrbmZDSKry1HaqWf5jNpUqan0Vgl4E+E5MFp/n1nRAvWfqmzDS0+5ETq/aRg23ROmvSC2aJRZZ5svtJWLWtsAPjDES/6Co0MTWGvSr2L5P27OhTyS6+LLO4OKJM7mkrp6NS/yvAgZ2dM/YDOJPaqHi019c/xClBEqunW+YQT8t28poiNVrVJWii6HWC3BOgWt9U5lhDr/OC5gwhjapBA1VstT6V17OTmhRuv35TJxV0/T6UPjW/dk07l04Hqr/qRAwXBPOBEFIG9MaAthG+vnlhSSnk/AMXQp8QReMfXa1at6Xr6Hqz4DRy9R0/c/n3mh2vn4iK8ZBneP/gYzBv1Uvl1wls4GDpibtquVq/YEflXnwoi5EpCMEzVKd8la4643hbW1BDTz0S0FLrryBh0CKyJSEhJeIq5R6JBNNbFfxhLbtPTt60FbvenVehl4jcBOkdZYJM8fzig/rkVzxlezNJs2GCKmTbxE4p+kRS2m7TUt+12+Ysm2fMQi0U0NK0uyt8dTFr/ze1+kQVXuKanTRZnDfn/ohdW1K+cgI+B5YdoVNV1SRBNve42dpb0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(26005)(1076003)(6506007)(2616005)(6512007)(83380400001)(41300700001)(86362001)(4326008)(316002)(8676002)(8936002)(5660300002)(2906002)(44832011)(36756003)(66476007)(66556008)(66946007)(38350700005)(478600001)(6666004)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xnHMSz6VMptzwKMUd2qJE1wglsEI0YYXJHvxRuFl0eMKo9+M5fYenCVMI9Cc?=
 =?us-ascii?Q?ZyIrYQoZ+tpaUVm6rfIoo9l9q4cdXvrmlWL7OrY3JmiY5V22lAquxK28HqQa?=
 =?us-ascii?Q?ZjfXxH2GoWmtQhDzj4wXw0DbdVijkFPYKkuls3uAZ3nrY4TjIH8V1ICbZQqO?=
 =?us-ascii?Q?tpiorbgCLEzEWXr7RzGLkpK55SUJKY1p3UMKHDcV74HZhmqRDZigoDMUhawK?=
 =?us-ascii?Q?y1MAQkZXZHyKG8dkYRLJOMiDdxC+gYwsAPwkYgZxQ4nK8R7mFS2qJV2TwY1D?=
 =?us-ascii?Q?7M3AvIsJIOmbmDzzheq4WMl74ikSr+bOtbOUbglC7laYTpOOUl0RE7fxHJXS?=
 =?us-ascii?Q?rnQMf4KgfbQ9xuHpo3+DB3i4Vd4xERRjYfFcOL1hzQwQfhsWqRJqAwej1pei?=
 =?us-ascii?Q?A00ZQ2ZO5PKYB4deYjrI3CQ+k8AhhqLo8qS8KMypeM3zz0Ij9cJQZa9BrVjS?=
 =?us-ascii?Q?LI5+F3REpL9s56vIEzFktzNt9glUhqoDx9+atwmUMxon4ksnQjKgyggDB6YT?=
 =?us-ascii?Q?1ZvdN/OIRkK5Bs7R1a4RFR8bMzHjFjaK2wOpbOo6zYxf0BLAk9UQ3jOEWLI0?=
 =?us-ascii?Q?6vpJA5JQT6wTHZSHTgbZpl02cjcgKIcqqYDiNwiqnPY4B+CfTHiY2pahovCU?=
 =?us-ascii?Q?83ip7E4tQwR3rFqgBKP1dlXFXW9uAxojZQjL2r7R02SJjAp9a08hKqk2oKxo?=
 =?us-ascii?Q?+tSJaDXOzSMlPHlF+BarwL9iJF/f7uLhzZPuZsiARmo+Y+j+Txs2jRTAKJnt?=
 =?us-ascii?Q?m0ED6Pzyjf8gA3AeiPk9hmIB2mwbAW2+nCc9I/5PH88KFSQ8EAi68rziUR4R?=
 =?us-ascii?Q?yu9mBm6iMi8BBwX6pdgueOagb9RMfwEC6/1wu563HDUhlurSBGa9EXHUlwWE?=
 =?us-ascii?Q?fYHfP5GHHOp4b9zquv+uWE6vSCOICeKa2N5zIFUE2+apGoG5njVKxzubUhRH?=
 =?us-ascii?Q?cZwlkx9lJsq+Me/uF78+082g3vDlOcjR+GkBPrykXttauus3NIwMLOha49c7?=
 =?us-ascii?Q?ajV/1fJKDvUBcFF2zILGFA9AenvMTgR2o6v5YkwSARo+weRF7o5VRWCJt9Wf?=
 =?us-ascii?Q?x5HoKKRQ3T7T4jMkp5fHOgRWvrg2s/LuO9iGLGfreIqX6PPmhK7+E4HrJ5sV?=
 =?us-ascii?Q?MZ3SwpqCriwQn2tyxPayHsXBzvic0KN2jnFddmW3S8Rh/bhm1uyAtToGfCBs?=
 =?us-ascii?Q?MkJmSYt4D1rm3olxrJYMBMjG3cuzQ602cdKqo+9+mzVfjMqGRRG2Ci7XXmuL?=
 =?us-ascii?Q?/d77x67z065GsYURQB7ttXMIh1eIA1uC9AFS6BPXGOLFNrawxyewv6FUUS/v?=
 =?us-ascii?Q?3olD50lBOjMj4ssjcRZXejHHilbQjUUewNf6kAh+/xv6hVlI1j66eyaE4ojg?=
 =?us-ascii?Q?78BGJMgKdF9mjYuLSbLpXQFWt74D8p/DnSNjZ/xj4bNULp9piS1UySU6VlcH?=
 =?us-ascii?Q?GcxbU1D2KUcyLSCqmzXgPN7ji9cksYbdndFZBGrCCbhPmTS7KRvhXOAf5W2g?=
 =?us-ascii?Q?XCv1cZVJDWmiujxW1v59n+0rKDpxVAVJwLoYJ4IOELMjx0LthtpLn5OfwNX1?=
 =?us-ascii?Q?1RvnXqD6YzdhE3M9DStO2lM06yfOP6nTdxzjY/7V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a31e948-c4d9-4fe7-1045-08dc125066f9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:52:51.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hktZLTsxSmZKY1m5+gUZfImk2FTvFM0UfIkYCpfSF+86lHUcNolJvnk8ncyEILxaMKoeeAqre2Zw0miJLMRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8860

There's a use case that playback stream of a loopback cable works on
RW_INTERLEAVED mode while capture stream works on MMAP_INTERLEAVED mode:

aplay -Dhw:Loopback,0,0 S32_48K_2ch.wav;
arecord -Dplughw:Loopback,1,0 -fS32_LE -r16000 -c2 cap.wav;

The plug plugin handles only slave PCM support MMAP mode. Not only plug
plugin but also other plugins like direct plugins(dmix/dsnoop/dshare)
work on MMAP access mode. In this case capture stream is the slave
PCM works on MMAP_INTERLEAVED mode. However loopback_check_format()
rejects this access setting and return:

arecord: pcm_read:2240: read error: Input/output error

To fix it a function called is_access_interleaved() is introduced to
get if access is interleaved mode. If both access of capture stream and
playback stream is interleaved mode loopback_check_format() will allow
this kind of access setting.

Fixes: 462494565c27 ("ALSA: aloop: Add support for the non-interleaved access mode")
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/drivers/aloop.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index e87dc67f33c6..1c65e0a3b13c 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -322,6 +322,17 @@ static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
 	return 0;
 }
 
+static bool is_access_interleaved(snd_pcm_access_t access)
+{
+	switch (access) {
+	case SNDRV_PCM_ACCESS_MMAP_INTERLEAVED:
+	case SNDRV_PCM_ACCESS_RW_INTERLEAVED:
+		return true;
+	default:
+		return false;
+	}
+};
+
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
 	struct snd_pcm_runtime *runtime, *cruntime;
@@ -341,7 +352,8 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 	check = runtime->format != cruntime->format ||
 		runtime->rate != cruntime->rate ||
 		runtime->channels != cruntime->channels ||
-		runtime->access != cruntime->access;
+		is_access_interleaved(runtime->access) !=
+		is_access_interleaved(cruntime->access);
 	if (!check)
 		return 0;
 	if (stream == SNDRV_PCM_STREAM_CAPTURE) {
@@ -369,7 +381,8 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 							&setup->channels_id);
 			setup->channels = runtime->channels;
 		}
-		if (setup->access != runtime->access) {
+		if (is_access_interleaved(setup->access) !=
+		    is_access_interleaved(runtime->access)) {
 			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
 							&setup->access_id);
 			setup->access = runtime->access;
@@ -584,8 +597,7 @@ static void copy_play_buf(struct loopback_pcm *play,
 			size = play->pcm_buffer_size - src_off;
 		if (dst_off + size > capt->pcm_buffer_size)
 			size = capt->pcm_buffer_size - dst_off;
-		if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
-		    runtime->access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED)
+		if (!is_access_interleaved(runtime->access))
 			copy_play_buf_part_n(play, capt, size, src_off, dst_off);
 		else
 			memcpy(dst + dst_off, src + src_off, size);
@@ -1544,8 +1556,7 @@ static int loopback_access_get(struct snd_kcontrol *kcontrol,
 	mutex_lock(&loopback->cable_lock);
 	access = loopback->setup[kcontrol->id.subdevice][kcontrol->id.device].access;
 
-	ucontrol->value.enumerated.item[0] = access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
-					     access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED;
+	ucontrol->value.enumerated.item[0] = !is_access_interleaved(access);
 
 	mutex_unlock(&loopback->cable_lock);
 	return 0;
-- 
2.42.0


