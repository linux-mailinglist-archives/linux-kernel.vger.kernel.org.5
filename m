Return-Path: <linux-kernel+bounces-14665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984F182207A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7F2816CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375A154BD;
	Tue,  2 Jan 2024 17:38:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A45154A9;
	Tue,  2 Jan 2024 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 2AAD42002EC;
	Tue,  2 Jan 2024 17:38:32 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id E6FCBA0083; Tue,  2 Jan 2024 18:37:45 +0100 (CET)
Date: Tue, 2 Jan 2024 18:37:45 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
Message-ID: <ZZRJ6VNJlQ97bnjF@shine.dominikbrodowski.net>
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
 <87sf3lxiet.wl-tiwai@suse.de>
 <ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
 <874jg1x7ao.wl-tiwai@suse.de>
 <ZY_Gb8-rncuOjRq-@shine.dominikbrodowski.net>
 <87plyovwg7.wl-tiwai@suse.de>
 <3260e806-a708-4462-9d4e-346e54143a65@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3260e806-a708-4462-9d4e-346e54143a65@linux.intel.com>

Am Tue, Jan 02, 2024 at 11:08:47AM +0200 schrieb Péter Ujfalusi:
> 
> 
> On 30/12/2023 12:03, Takashi Iwai wrote:
> > On Sat, 30 Dec 2023 08:27:43 +0100,
> > Dominik Brodowski wrote:
> >>
> >> Am Fri, Dec 29, 2023 at 06:11:43PM +0100 schrieb Takashi Iwai:
> >>> On Fri, 29 Dec 2023 16:24:18 +0100,
> >>> Dominik Brodowski wrote:
> >>>>
> >>>> Hi Takashi,
> >>>>
> >>>> many thanks for your response. Your patch helps half-way: the oops goes
> >>>> away, but so does the sound... With your patch, the decisive lines in dmesg
> >>>> are:
> >>>>
> >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> >>>> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> >>>> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> >>>> 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> >>>> 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> >>>> 	platform sof_sdw: deferred probe pending
> >>>>
> >>>> With a revert of the a0575b4add21, it is:
> >>>>
> >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> >>>> 	sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
> >>>> 	sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
> >>>> 	sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
> >>>> 	input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input14
> >>>> 	input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input15
> >>>> 	input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input16
> >>>>
> >>>> Maybe this helps a bit further?
> >>>
> >>> Thanks for quick testing.
> >>> It shows at least that my guess wasn't wrong.
> >>>
> >>> The problem could be the initialization order in the caller side.
> >>> Can the patch below work instead?
> >>
> >> Unfortunately, no:
> >>
> >> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> >> sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> >> sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> >> sof_sdw sof_sdw: snd_soc_register_card failed -517
> >> sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> >> sof_sdw sof_sdw: snd_soc_register_card failed -517
> >> platform sof_sdw: deferred probe pending
> > 
> > Hm, then it might be the logical failure of that commit.
> > Peter?
> > 
> > Without a fix in the next few days, we'll have to revert it before
> > 6.7.
> 
> The fix for this was sent early December:
> https://lore.kernel.org/linux-sound/20231207095425.19597-1-peter.ujfalusi@linux.intel.com/

Yes, that patch fixes the issue (all built-in here).

Thanks,
	Dominik

