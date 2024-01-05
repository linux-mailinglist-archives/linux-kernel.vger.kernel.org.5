Return-Path: <linux-kernel+bounces-17550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57A0824F3B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A365B2262C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686391EB45;
	Fri,  5 Jan 2024 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3XhhbDk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4791EB3D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-556aa7fe765so1426000a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 23:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704440217; x=1705045017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWf9gZj82e+HJtfBdWUmE6T7orNWatXwoddmaVCfxOw=;
        b=A3XhhbDko/D7ObPi5blSeLjAv57ptP5YbfJieFsYBc42xR16w2eYBpSZlg87xN10jq
         p+1HgUhiC5vCG1YhH/08f6hvXjQNCIl88bo00iKwbpfLql+4ul6ReYW/hfSVaU0eFfmo
         90ob111qQ7b+BDAI8h/90fTLRlpPQYo7cC9twt/iyd0cghFL7GB2pNj2Uc0d14tCH1vQ
         yxvK3r01RvT2BBniIbvvScibmRNIBNMEtjT8ml1GBMmEppRHaJnEL5wnyiuezcRCBiwl
         BG/xByH92ppFugA21XARouA0WJTLRurS+CWFZ/2bqpd6EGMbfzWE6GJPoO/7vKfwgaRw
         prrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704440217; x=1705045017;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWf9gZj82e+HJtfBdWUmE6T7orNWatXwoddmaVCfxOw=;
        b=GYa7Fg43tdg2tFYR4tu0qMIwkF7c7wLXYIu5pSJVPWofFDKUrJYnj9CJjs+YlvuU11
         nMaNBG9XrhKPzMXZbOhdB3tKDaz9qHvS3z6fYGc9YvxMzHKj4hTUGgud59MrGSCvIBZ0
         JI4xgJfDa7g4cvhCurtn7unv9rF4mIscID4Q8hdZzb1x6ZPE/IOmZTYBoKl1zoEm7QxU
         GynR56bcc7WuB3MON6tJFhqlRqkUUWADhj60BbuZ3HrgZuY9WuH+Gt2FW7nNRicU1fBv
         qAsm3Oj97owYRGgGjPov5gHfUeW8Rjq0oEhORhX/gyMvDZWBSC/4CtK8NohNlnKN8gtC
         d2/w==
X-Gm-Message-State: AOJu0YyQvJQqDSFhwychY4IPNAle0r8WwDgF+xpvgHA+V9VecMUVEAPG
	2cXaOmhN+x9TT271kIhlC/IyDy184vC31Q==
X-Google-Smtp-Source: AGHT+IE08mASYDVZ8EMDjUOq+GOBJdiUSJUSPv3cdGxHPIA3izh7vy9xoIDpWSLxaTJeAOBKASFXLA==
X-Received: by 2002:a50:9e06:0:b0:553:620c:89b6 with SMTP id z6-20020a509e06000000b00553620c89b6mr1080028ede.10.1704440216760;
        Thu, 04 Jan 2024 23:36:56 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id u7-20020a50eac7000000b005553a8bb61dsm629665edp.87.2024.01.04.23.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 23:36:56 -0800 (PST)
Date: Fri, 5 Jan 2024 10:36:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Zhipeng Lu <alexious@zju.edu.cn>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ALSA: hdsp: fix some memleaks in
 snd_hdsp_hwdep_ioctl
Message-ID: <9e51487b-28de-4109-8f94-70a523df09e3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227060322.3556052-1-alexious@zju.edu.cn>

Hi Zhipeng,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhipeng-Lu/ALSA-hdsp-fix-some-memleaks-in-snd_hdsp_hwdep_ioctl/20231227-140703
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20231227060322.3556052-1-alexious%40zju.edu.cn
patch subject: [PATCH] [v2] ALSA: hdsp: fix some memleaks in snd_hdsp_hwdep_ioctl
config: i386-randconfig-141-20240104 (https://download.01.org/0day-ci/archive/20240105/202401051031.8odmcqKi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202401051031.8odmcqKi-lkp@intel.com/

New smatch warnings:
sound/pci/rme9652/hdsp.c:4918 snd_hdsp_hwdep_ioctl() error: uninitialized symbol 'err'.

Old smatch warnings:
sound/pci/rme9652/hdsp.c:3405 snd_hdsp_proc_read() warn: argument 5 to %lx specifier is cast from pointer
sound/pci/rme9652/hdsp.c:5219 hdsp_request_fw_loader() warn: 'fw' from request_firmware() not released on lines: 5197,5202,5208,5216.

vim +/err +4918 sound/pci/rme9652/hdsp.c

55e957d8328ef1 Takashi Iwai   2005-11-17  4728  static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigned int cmd, unsigned long arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  4729  {
9fe856e47e1751 Joe Perches    2010-09-04  4730  	struct hdsp *hdsp = hw->private_data;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4731  	void __user *argp = (void __user *)arg;
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4732  	int err;

err is first declared here

^1da177e4c3f41 Linus Torvalds 2005-04-16  4733  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4734  	switch (cmd) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  4735  	case SNDRV_HDSP_IOCTL_GET_PEAK_RMS: {
55e957d8328ef1 Takashi Iwai   2005-11-17  4736  		struct hdsp_peak_rms __user *peak_rms = (struct hdsp_peak_rms __user *)arg;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4737  
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4738  		err = hdsp_check_for_iobox(hdsp);
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4739  		if (err < 0)
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4740  			return err;
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4741  
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4742  		err = hdsp_check_for_firmware(hdsp, 1);
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4743  		if (err < 0)
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4744  			return err;
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4745  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4746  		if (!(hdsp->state & HDSP_FirmwareLoaded)) {
a54ba0fe9fae3c Takashi Iwai   2014-02-26  4747  			dev_err(hdsp->card->dev,
a54ba0fe9fae3c Takashi Iwai   2014-02-26  4748  				"firmware needs to be uploaded to the card.\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  4749  			return -EINVAL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4750  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4751  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4752  		switch (hdsp->io_type) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  4753  		case H9652:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4754  			return hdsp_9652_get_peak(hdsp, peak_rms);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4755  		case H9632:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4756  			return hdsp_9632_get_peak(hdsp, peak_rms);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4757  		default:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4758  			return hdsp_get_peak(hdsp, peak_rms);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4759  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4760  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4761  	case SNDRV_HDSP_IOCTL_GET_CONFIG_INFO: {
55e957d8328ef1 Takashi Iwai   2005-11-17  4762  		struct hdsp_config_info info;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4763  		unsigned long flags;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4764  		int i;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4765  
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4766  		err = hdsp_check_for_iobox(hdsp);
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4767  		if (err < 0)
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4768  			return err;
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4769  
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4770  		err = hdsp_check_for_firmware(hdsp, 1);
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4771  		if (err < 0)
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4772  			return err;
3ae7e2e22900b9 Tim Blechmann  2008-11-08  4773  
e68d3b316ab7b0 Dan Rosenberg  2010-09-25  4774  		memset(&info, 0, sizeof(info));
^1da177e4c3f41 Linus Torvalds 2005-04-16  4775  		spin_lock_irqsave(&hdsp->lock, flags);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4776  		info.pref_sync_ref = (unsigned char)hdsp_pref_sync_ref(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4777  		info.wordclock_sync_check = (unsigned char)hdsp_wc_sync_check(hdsp);
b0b9811956db48 Takashi Iwai   2005-10-20  4778  		if (hdsp->io_type != H9632)
^1da177e4c3f41 Linus Torvalds 2005-04-16  4779  		    info.adatsync_sync_check = (unsigned char)hdsp_adatsync_sync_check(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4780  		info.spdif_sync_check = (unsigned char)hdsp_spdif_sync_check(hdsp);
28b26e15533e60 Florian Faber  2010-12-01  4781  		for (i = 0; i < ((hdsp->io_type != Multiface && hdsp->io_type != RPM && hdsp->io_type != H9632) ? 3 : 1); ++i)
^1da177e4c3f41 Linus Torvalds 2005-04-16  4782  			info.adat_sync_check[i] = (unsigned char)hdsp_adat_sync_check(hdsp, i);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4783  		info.spdif_in = (unsigned char)hdsp_spdif_in(hdsp);
4833c673dee69a Adrian Knoth   2013-01-15  4784  		info.spdif_out = (unsigned char)hdsp_toggle_setting(hdsp,
4833c673dee69a Adrian Knoth   2013-01-15  4785  				HDSP_SPDIFOpticalOut);
4833c673dee69a Adrian Knoth   2013-01-15  4786  		info.spdif_professional = (unsigned char)
4833c673dee69a Adrian Knoth   2013-01-15  4787  			hdsp_toggle_setting(hdsp, HDSP_SPDIFProfessional);
4833c673dee69a Adrian Knoth   2013-01-15  4788  		info.spdif_emphasis = (unsigned char)
4833c673dee69a Adrian Knoth   2013-01-15  4789  			hdsp_toggle_setting(hdsp, HDSP_SPDIFEmphasis);
4833c673dee69a Adrian Knoth   2013-01-15  4790  		info.spdif_nonaudio = (unsigned char)
4833c673dee69a Adrian Knoth   2013-01-15  4791  			hdsp_toggle_setting(hdsp, HDSP_SPDIFNonAudio);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4792  		info.spdif_sample_rate = hdsp_spdif_sample_rate(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4793  		info.system_sample_rate = hdsp->system_sample_rate;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4794  		info.autosync_sample_rate = hdsp_external_sample_rate(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4795  		info.system_clock_mode = (unsigned char)hdsp_system_clock_mode(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4796  		info.clock_source = (unsigned char)hdsp_clock_source(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4797  		info.autosync_ref = (unsigned char)hdsp_autosync_ref(hdsp);
4833c673dee69a Adrian Knoth   2013-01-15  4798  		info.line_out = (unsigned char)
4833c673dee69a Adrian Knoth   2013-01-15  4799  			hdsp_toggle_setting(hdsp, HDSP_LineOut);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4800  		if (hdsp->io_type == H9632) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  4801  			info.da_gain = (unsigned char)hdsp_da_gain(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4802  			info.ad_gain = (unsigned char)hdsp_ad_gain(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4803  			info.phone_gain = (unsigned char)hdsp_phone_gain(hdsp);
4833c673dee69a Adrian Knoth   2013-01-15  4804  			info.xlr_breakout_cable =
4833c673dee69a Adrian Knoth   2013-01-15  4805  				(unsigned char)hdsp_toggle_setting(hdsp,
4833c673dee69a Adrian Knoth   2013-01-15  4806  					HDSP_XLRBreakoutCable);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4807  
28b26e15533e60 Florian Faber  2010-12-01  4808  		} else if (hdsp->io_type == RPM) {
28b26e15533e60 Florian Faber  2010-12-01  4809  			info.da_gain = (unsigned char) hdsp_rpm_input12(hdsp);
28b26e15533e60 Florian Faber  2010-12-01  4810  			info.ad_gain = (unsigned char) hdsp_rpm_input34(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4811  		}
b0b9811956db48 Takashi Iwai   2005-10-20  4812  		if (hdsp->io_type == H9632 || hdsp->io_type == H9652)
4833c673dee69a Adrian Knoth   2013-01-15  4813  			info.analog_extension_board =
4833c673dee69a Adrian Knoth   2013-01-15  4814  				(unsigned char)hdsp_toggle_setting(hdsp,
4833c673dee69a Adrian Knoth   2013-01-15  4815  					    HDSP_AnalogExtensionBoard);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4816  		spin_unlock_irqrestore(&hdsp->lock, flags);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4817  		if (copy_to_user(argp, &info, sizeof(info)))
^1da177e4c3f41 Linus Torvalds 2005-04-16  4818  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4819  		break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4820  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4821  	case SNDRV_HDSP_IOCTL_GET_9632_AEB: {
55e957d8328ef1 Takashi Iwai   2005-11-17  4822  		struct hdsp_9632_aeb h9632_aeb;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4823  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4824  		if (hdsp->io_type != H9632) return -EINVAL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4825  		h9632_aeb.aebi = hdsp->ss_in_channels - H9632_SS_CHANNELS;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4826  		h9632_aeb.aebo = hdsp->ss_out_channels - H9632_SS_CHANNELS;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4827  		if (copy_to_user(argp, &h9632_aeb, sizeof(h9632_aeb)))
^1da177e4c3f41 Linus Torvalds 2005-04-16  4828  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4829  		break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4830  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4831  	case SNDRV_HDSP_IOCTL_GET_VERSION: {
55e957d8328ef1 Takashi Iwai   2005-11-17  4832  		struct hdsp_version hdsp_version;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4833  		int err;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4834  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4835  		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4836  		if (hdsp->io_type == Undefined) {
66c8f75919dd85 Takashi Iwai   2021-06-08  4837  			err = hdsp_get_iobox_version(hdsp);
66c8f75919dd85 Takashi Iwai   2021-06-08  4838  			if (err < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  4839  				return err;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4840  		}
d14df339c72b6e Dan Carpenter  2013-10-16  4841  		memset(&hdsp_version, 0, sizeof(hdsp_version));
^1da177e4c3f41 Linus Torvalds 2005-04-16  4842  		hdsp_version.io_type = hdsp->io_type;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4843  		hdsp_version.firmware_rev = hdsp->firmware_rev;
0f7c956533680d Dan Carpenter  2021-06-22  4844  		if (copy_to_user(argp, &hdsp_version, sizeof(hdsp_version)))
^1da177e4c3f41 Linus Torvalds 2005-04-16  4845  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4846  		break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4847  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4848  	case SNDRV_HDSP_IOCTL_UPLOAD_FIRMWARE: {
112e3f5ac505ea Takashi Iwai   2020-02-02  4849  		struct hdsp_firmware firmware;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4850  		u32 __user *firmware_data;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4851  		int err;

This err shadows the earlier declaration

^1da177e4c3f41 Linus Torvalds 2005-04-16  4852  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4853  		if (hdsp->io_type == H9652 || hdsp->io_type == H9632) return -EINVAL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4854  		/* SNDRV_HDSP_IOCTL_GET_VERSION must have been called */
^1da177e4c3f41 Linus Torvalds 2005-04-16  4855  		if (hdsp->io_type == Undefined) return -EINVAL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4856  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4857  		if (hdsp->state & (HDSP_FirmwareCached | HDSP_FirmwareLoaded))
^1da177e4c3f41 Linus Torvalds 2005-04-16  4858  			return -EBUSY;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4859  
a54ba0fe9fae3c Takashi Iwai   2014-02-26  4860  		dev_info(hdsp->card->dev,
a54ba0fe9fae3c Takashi Iwai   2014-02-26  4861  			 "initializing firmware upload\n");
112e3f5ac505ea Takashi Iwai   2020-02-02  4862  		if (copy_from_user(&firmware, argp, sizeof(firmware)))
^1da177e4c3f41 Linus Torvalds 2005-04-16  4863  			return -EFAULT;
112e3f5ac505ea Takashi Iwai   2020-02-02  4864  		firmware_data = (u32 __user *)firmware.firmware_data;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4865  
b0b9811956db48 Takashi Iwai   2005-10-20  4866  		if (hdsp_check_for_iobox (hdsp))
^1da177e4c3f41 Linus Torvalds 2005-04-16  4867  			return -EIO;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4868  
90caaef6a1ce2e Takashi Iwai   2012-11-22  4869  		if (!hdsp->fw_uploaded) {
90caaef6a1ce2e Takashi Iwai   2012-11-22  4870  			hdsp->fw_uploaded = vmalloc(HDSP_FIRMWARE_SIZE);
90caaef6a1ce2e Takashi Iwai   2012-11-22  4871  			if (!hdsp->fw_uploaded)
90caaef6a1ce2e Takashi Iwai   2012-11-22  4872  				return -ENOMEM;
90caaef6a1ce2e Takashi Iwai   2012-11-22  4873  		}
90caaef6a1ce2e Takashi Iwai   2012-11-22  4874  
90caaef6a1ce2e Takashi Iwai   2012-11-22  4875  		if (copy_from_user(hdsp->fw_uploaded, firmware_data,
90caaef6a1ce2e Takashi Iwai   2012-11-22  4876  				   HDSP_FIRMWARE_SIZE)) {
b0d4acf304f079 Zhipeng Lu     2023-12-27  4877  			err = -EFAULT;
b0d4acf304f079 Zhipeng Lu     2023-12-27  4878  			goto free_fw_uploaded;
90caaef6a1ce2e Takashi Iwai   2012-11-22  4879  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4880  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4881  		hdsp->state |= HDSP_FirmwareCached;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4882  
66c8f75919dd85 Takashi Iwai   2021-06-08  4883  		err = snd_hdsp_load_firmware_from_cache(hdsp);
66c8f75919dd85 Takashi Iwai   2021-06-08  4884  		if (err < 0)
b0d4acf304f079 Zhipeng Lu     2023-12-27  4885  			goto free_fw_uploaded;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4886  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4887  		if (!(hdsp->state & HDSP_InitializationComplete)) {
66c8f75919dd85 Takashi Iwai   2021-06-08  4888  			err = snd_hdsp_enable_io(hdsp);
66c8f75919dd85 Takashi Iwai   2021-06-08  4889  			if (err < 0)
b0d4acf304f079 Zhipeng Lu     2023-12-27  4890  				goto free_fw_uploaded;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4891  
^1da177e4c3f41 Linus Torvalds 2005-04-16  4892  			snd_hdsp_initialize_channels(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4893  			snd_hdsp_initialize_midi_flush(hdsp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  4894  
66c8f75919dd85 Takashi Iwai   2021-06-08  4895  			err = snd_hdsp_create_alsa_devices(hdsp->card, hdsp);
66c8f75919dd85 Takashi Iwai   2021-06-08  4896  			if (err < 0) {
a54ba0fe9fae3c Takashi Iwai   2014-02-26  4897  				dev_err(hdsp->card->dev,
a54ba0fe9fae3c Takashi Iwai   2014-02-26  4898  					"error creating alsa devices\n");
b0d4acf304f079 Zhipeng Lu     2023-12-27  4899  				goto free_fw_uploaded;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4900  			}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4901  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4902  		break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4903  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4904  	case SNDRV_HDSP_IOCTL_GET_MIXER: {
55e957d8328ef1 Takashi Iwai   2005-11-17  4905  		struct hdsp_mixer __user *mixer = (struct hdsp_mixer __user *)argp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4906  		if (copy_to_user(mixer->matrix, hdsp->mixer_matrix, sizeof(unsigned short)*HDSP_MATRIX_MIXER_SIZE))
^1da177e4c3f41 Linus Torvalds 2005-04-16  4907  			return -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4908  		break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4909  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4910  	default:
^1da177e4c3f41 Linus Torvalds 2005-04-16  4911  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  4912  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  4913  	return 0;
b0d4acf304f079 Zhipeng Lu     2023-12-27  4914  
b0d4acf304f079 Zhipeng Lu     2023-12-27  4915  free_fw_uploaded:
b0d4acf304f079 Zhipeng Lu     2023-12-27  4916  	vfree(hdsp->fw_uploaded);
b0d4acf304f079 Zhipeng Lu     2023-12-27  4917  	hdsp->fw_uploaded = NULL;
b0d4acf304f079 Zhipeng Lu     2023-12-27 @4918  	return err;

The first err is uninitialized.

^1da177e4c3f41 Linus Torvalds 2005-04-16  4919  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


