Return-Path: <linux-kernel+bounces-154004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A78AD602
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8FF1F21F45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6931BC44;
	Mon, 22 Apr 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xq5vzR8u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775441B947;
	Mon, 22 Apr 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818578; cv=none; b=rOLR3zJhA3rSGMnbH0Uk2JCvrJ1nqxLm7lwk+HFl9UIDJDCYZaJio/Z3R2Iu01KhPsctLyydLRKQY9/Rt1si2emVfNqhieY5StNCkfNzcKl0/tB6+MCIOxj9YeNr/6jy64nHyUasVCmfUfaXvbNyNbWTv3UNsPDuoG9nPFQLsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818578; c=relaxed/simple;
	bh=21plNlwF84LiSmR/a7cPmVx+DowVztKcBCbH9tBCfs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3+m7L9Jcsrp2yQpfezJd/H8+v7e5B9gq3rU46l4QBx0upu0lfDoiAy/hqJduHd3NXFsDWiOPS7L0npZY/yWasBtSi/DJ+Zkl/GPF629s1S4/Gg9Dsg5QEkSOthVVxkAASB0/TvM8+e5vU9yg++gSDyhco76ne6RumMIO7QLTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xq5vzR8u; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818577; x=1745354577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=21plNlwF84LiSmR/a7cPmVx+DowVztKcBCbH9tBCfs0=;
  b=Xq5vzR8u1honqPqn70ycQYQYUOd5fS5ZqNI11He8dUtkh0hg4f984R4u
   04jIuB18JF+oSsR0c6Rdf9GWwweVNWKGqqPHsuvGZaLicQIDnohrrjWi+
   1BPqOSNT2FpRHeBrChxVVwOfqSlFOjG09TLjRHf6yfMDGU4LbhfOwq5ue
   dF+DPM8uqwT2YcoW1i4Csupc4qXTTjdKX9LlxTfBjGQ2EpJ9jEGviQbNg
   nhewM5J28/IDKt4FlP8JHvs57lhtau8M9S1Pot3RilDlJGv0iB+Zzc4On
   hNEb7ngZM6UchaGJRDq1nVu4dzTUw5hdxUOzNXfmFM6McVQmKEOjqDSae
   g==;
X-CSE-ConnectionGUID: HWDZ7qzzSCGSn9M11rOLsQ==
X-CSE-MsgGUID: LDXiWKJVR9ybxckOj1TcfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9234754"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9234754"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:42:03 -0700
X-CSE-ConnectionGUID: nHk9q7c0QZK4QyNVPsdbgQ==
X-CSE-MsgGUID: g0m2gNKLQIu8zJeDlFQ+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24747792"
Received: from leozhang-mobl.amr.corp.intel.com (HELO [10.212.37.174]) ([10.212.37.174])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:42:00 -0700
Message-ID: <3acfbe3c-8b83-4c40-83c2-437f963fd25a@linux.intel.com>
Date: Mon, 22 Apr 2024 15:42:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] ASoC: Constify local snd_sof_dsp_ops
To: Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
 <89f8f0be-2534-46c8-9058-cabea4f68568@linux.intel.com>
 <9d1eda85-32a0-4e53-86ca-ce3137439bd7@kernel.org>
 <d046d195-6fa3-4c52-bc5f-3e5e763bc692@linux.intel.com>
 <138ac465-1576-4e86-a05d-63f8acc6fb70@kernel.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <138ac465-1576-4e86-a05d-63f8acc6fb70@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> There are multiple reasons and benefits for const, like compiler
> optimization, code readability (meaning) up to security improvements,
> e.g. by some GCC plugins or marking rodata as really non-writeable, so
> closing some ways of exploits. There are many opportunities here, even
> if they are not yet enabled.

Possibly, but the SOF core does not know if the structure it uses is
rodata or not. Using the 'const' identifier would be misleading.

>> that's a different interpretation to the 'software' view you're
>> describing. "this structure will not modified by this function" is not
>> the same thing as "this structure CANNOT be modified".
> 
> Yes, but can we please discuss specific patchset then? Patches which
> change pointers to const have one "interpretation". Patches which modify
> static or global data have another.

Just look at sound/soc/sof/intel/mtl.c... The core will sometimes use a
constant structure and sometimes not, depending on the PCI ID reported
by hardware. This was intentional to override common defaults and make
the differences limited in scope between hardware generations.

int sof_mtl_ops_init(struct snd_sof_dev *sdev)
{
	struct sof_ipc4_fw_data *ipc4_data;

	/* common defaults */
	memcpy(&sof_mtl_ops, &sof_hda_common_ops, sizeof(struct
snd_sof_dsp_ops)); <<<< THE BASELINE IS CONSTANT

        <<< THE REST ISN'T.

	/* shutdown */
	sof_mtl_ops.shutdown = hda_dsp_shutdown;

	/* doorbell */
	sof_mtl_ops.irq_thread = mtl_ipc_irq_thread;

	/* ipc */
	sof_mtl_ops.send_msg = mtl_ipc_send_msg;
	sof_mtl_ops.get_mailbox_offset = mtl_dsp_ipc_get_mailbox_offset;
	sof_mtl_ops.get_window_offset = mtl_dsp_ipc_get_window_offset;

	/* debug */
	sof_mtl_ops.debug_map = mtl_dsp_debugfs;
	sof_mtl_ops.debug_map_count = ARRAY_SIZE(mtl_dsp_debugfs);
	sof_mtl_ops.dbg_dump = mtl_dsp_dump;
	sof_mtl_ops.ipc_dump = mtl_ipc_dump;

