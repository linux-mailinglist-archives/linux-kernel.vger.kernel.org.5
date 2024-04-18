Return-Path: <linux-kernel+bounces-149864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7238B8A96F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1153C1F234E4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B115B57F;
	Thu, 18 Apr 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES2zQAiq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD815B544;
	Thu, 18 Apr 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434700; cv=none; b=SY/fFleQNeuA9s3Fe8U89+8sxHj5o1Vmgj4pJV5TUv2RNbai5sfB/VsRg/YRqVj3pd43JZaF7v7Nq20BNrP6qhLJIwrb3d+NF+qBdXE3ATW+u3HsDoKBrfteowJMi7nTTnUJ/zuqDh5NKQ7fmKohZhv8nmQ8VICT7f2DmUe0obc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434700; c=relaxed/simple;
	bh=LwQOF5GIBi0GuSs+JnaNPA7CehP+tyQkRU7uPocooMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdIVTEwOQSxONA1dendjeNkPOSjb90boR1BPnxKOQgqnkEqmOTn+Ns6wP/pumBaJEhpTChWZshWcBrwGttyqJt1xc9dig6Rjghgd+enRdRMGzOgnaxhVmNUrn6izGGT5JiRPNc8Joejq4eQiW1CIDj+ynLWm1yLDCNPzuheBDgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES2zQAiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30515C113CC;
	Thu, 18 Apr 2024 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713434700;
	bh=LwQOF5GIBi0GuSs+JnaNPA7CehP+tyQkRU7uPocooMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ES2zQAiqNQM8vuvknyz10WlCyWB8BhMoNugq3tHoAg+4gY7miz4XzJ+uApy0eli6k
	 craeU6QIsLgpzPqLED+pkmlKC7n40/HRN/00ebMAGKSkhEK2rKCy9ZkiEwk+4s8BI5
	 l/Cy5H8ltUnmvgsn3gnsy0TlcUgsHlDu19/hlBn8mgsKZo+A83iFMiLwkvGyp2xZQt
	 T2VxZ2odRLrGhF/hHPuNn89u69BH/pQmu3TRpUPW2ADlG+NDvAWjhRBhmhpBU2DCH3
	 wHegU+el09jgDM7w+YWurvRi5cGM/92P2140C8BCBNyk5OhO957M/bvzxNbgCJIYxZ
	 q+gvjXPYeDXGQ==
Date: Thu, 18 Apr 2024 11:04:53 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bard Liao
 <yung-chuan.liao@linux.intel.com>, Brady Norander
 <bradynorander@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown
 <broonie@kernel.org>, Mark Hasemeyer <markhas@chromium.org>, Takashi Iwai
 <tiwai@suse.com>, linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14
 NBLB-WAX9N quirk detection
Message-ID: <20240418110453.10efcb60@sal.lan>
In-Reply-To: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Apr 2024 09:48:27 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> Newer Matebook D14 model comes with essx8336 and supports SOF,
> but the initial models use the legacy driver, with a Realtek ALC 256
> AC97 chip on it.
> 
> The BIOS seems to be prepared to be used by both models, so
> it contains an entry for ESSX8336 on its DSDT table.
> 
> Add a quirk, as otherwise dspconfig driver will try to load
> SOF, causing audio probe to fail.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Worth to mention that I opened an issue on Github about that:

https://github.com/thesofproject/linux/issues/4934

I added there the ACPI DSDT table as a reference.


> ---
>  sound/hda/intel-dsp-config.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> index 6a384b922e4f..8e728f0585dd 100644
> --- a/sound/hda/intel-dsp-config.c
> +++ b/sound/hda/intel-dsp-config.c
> @@ -46,6 +46,22 @@ static const struct snd_soc_acpi_codecs __maybe_unused essx_83x6 = {
>   * - the first successful match will win
>   */
>  static const struct config_entry config_table[] = {
> +	/* Quirks */
> +	{
> +		.flags = 0,	/* Model uses AC97 with Realtek ALC 256 */
> +		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
> +		.dmi_table = (const struct dmi_system_id []) {
> +			{
> +				.ident = "Huawei NBLB-WAX9N",
> +				.matches = {
> +					DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
> +					DMI_MATCH(DMI_PRODUCT_NAME, "NBLB-WAX9N"),
> +				}
> +			},
> +			{}
> +		}
> +	},
> +
>  /* Merrifield */
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
>  	{

