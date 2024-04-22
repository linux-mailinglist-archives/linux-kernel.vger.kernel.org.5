Return-Path: <linux-kernel+bounces-153919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95F8AD4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9491C2121D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD2415533B;
	Mon, 22 Apr 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HHhavi+9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6dR0hyW3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DN+IbO3O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6l5yAp9L"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24925025E;
	Mon, 22 Apr 2024 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814253; cv=none; b=tg7PU+rRSFLXGVtuHgTTmyyD8wZDmtTKXol3P6BukmOk5YNgLbhAn4VB+6hQPNkE4C7E1m0IP1HhCB1X/PuwH9bpTLd/+PLWfEyhzJIhoYsVCfIH0ePvuhfttMUo0JFC5sXZnVO8KnIMRfTJeaFG8c+Gh+V17yha6vQ3JztViN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814253; c=relaxed/simple;
	bh=KrqLQxY8MNNZTtlKm+hxEOGdekXiZtGWcodHhjg3tu0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAdIxCCTXt+JO2TEoOZmBjObm4Cxmie63lsHXQJmsc6ornAyo4AEdtyEN0sv9x6W78GpoRh2F0HeGk5g2ihGBbSqbmF1yKqDabOjeBuJ9KxYv04rOT6UkSIF2FGULKDkbJ2HX7JVfb7+1e4egFg30amrp/Rjt0XK6Z8bV039bsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HHhavi+9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6dR0hyW3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DN+IbO3O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6l5yAp9L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6A485D514;
	Mon, 22 Apr 2024 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713814250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra3e3cDvf4azeKnE5GPwyR5UD1bEeFV+gj5m/O8jNuY=;
	b=HHhavi+9J0kI9qjD+iF2F3ijUr1GH2uFkkMxR+99BFAxN/n5WwLWCEil/I9oDgporrNGjc
	2vSVEUGYgHXHV4zk6W1VXW3kCM9yr8KDEGLpwPpp3SyZNCnPJXU7L2SIUJ+T0G2H5H4lDl
	ACr6RMiiTsgVWG8y1YWNQ9mC/jAKdbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713814250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra3e3cDvf4azeKnE5GPwyR5UD1bEeFV+gj5m/O8jNuY=;
	b=6dR0hyW3AV1yQw0LBwfS5V1LoVlCkkFddp1GWQI6IgTEAXCSDATkHIpZsOua8G+sTCZIPk
	R6CFS1urNfhAqFBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DN+IbO3O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6l5yAp9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713814249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra3e3cDvf4azeKnE5GPwyR5UD1bEeFV+gj5m/O8jNuY=;
	b=DN+IbO3ODipH3PJm+t4GHmC/CCQGv8F+EUMGPD8D/WSf/UGiRwHLsIZE+Qdacg3b6TQhKN
	/IiasBdy6B9Ijp2PWMZfWvR96FntrasqmkMgCHIFNKgo472ZWEBuX112fpIiUNxjlAizyZ
	CDhhTSWo4EhW8BaE81OFsAIcGQq5row=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713814249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra3e3cDvf4azeKnE5GPwyR5UD1bEeFV+gj5m/O8jNuY=;
	b=6l5yAp9LWsonmY8Suen71OVEFHzMzWfaDmVMmEUIH9m0UGw1DAW9P6dPIJ5oPxK2tZCoe8
	5B8B1Z0MpVmUG1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CEA9136ED;
	Mon, 22 Apr 2024 19:30:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FYHzAem6JmbUQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Apr 2024 19:30:49 +0000
Date: Mon, 22 Apr 2024 21:30:57 +0200
Message-ID: <87zftli49a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Takashi Iwai <tiwai@suse.de>,
	"Yang, Chenyuan" <cy54@illinois.edu>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jani.nikula@intel.com" <jani.nikula@intel.com>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"Zhao, Zijie"
 <zijie4@illinois.edu>,
	"Zhang, Lingming" <lingming@illinois.edu>
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
In-Reply-To: <966f5847-d007-4425-a902-1e1c05a820ae@xs4all.nl>
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
	<f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
	<526380BE-57AC-493D-A7B0-B8F0ECC0FE0A@illinois.edu>
	<f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
	<2e5f1e92-7fad-4a74-b375-1e194ff08ce6@xs4all.nl>
	<F8D4A291-8CFB-4A25-B296-3CA07B56F459@illinois.edu>
	<49a68c10-9549-4fd8-b929-d4c7a9c8debf@xs4all.nl>
	<PH7PR11MB5768B0BC3C042A6EA4EC1EF0A0542@PH7PR11MB5768.namprd11.prod.outlook.com>
	<7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
	<87le59s8wi.wl-tiwai@suse.de>
	<966f5847-d007-4425-a902-1e1c05a820ae@xs4all.nl>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C6A485D514
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Mon, 22 Apr 2024 14:14:17 +0200,
Hans Verkuil wrote:
> 
> Hi Takashi,
> 
> On 19/04/2024 16:51, Takashi Iwai wrote:
> > On Mon, 26 Feb 2024 13:27:16 +0100,
> > Yang, Chenyuan wrote:
> >>
> >> Hi Hans,
> >>
> >> Thank you for your continued efforts in investigating this bug and implementing the new patch!
> >>
> >> Regarding the two warnings, they have been addressed by this new patch and are no longer reproducible. Additionally, I conducted a 48-hour fuzzing test on the CEC driver, which has successfully eliminated the previous hanging issue.
> >>
> >> One thing to note that the system will now log timeout events:
> >> ```
> >> [ 2281.265385][ T2034] cec-vivid-001-vid-out0: transmit timed out
> >> [ 2282.994510][ T2017] cec-vivid-000-vid-cap0: transmit timed out
> >> [ 2283.063484][ T2050] cec-vivid-002-vid-out0: transmit timed out
> >> [ 2283.073468][ T2065] cec-vivid-003-vid-cap0: transmit timed out
> >> [ 2283.373518][ T2033] cec-vivid-001-vid-cap0: transmit timed out
> >> [ 2285.113544][ T2018] cec-vivid-000-vid-out0: transmit timed out
> >> [ 2285.193502][ T2050] cec-vivid-002-vid-out0: transmit timed out
> >> [ 2285.193570][ T2065] cec-vivid-003-vid-cap0: transmit timed out
> >> [ 2285.513570][ T2033] cec-vivid-001-vid-cap0: transmit timed out
> 
> >> ```
> >>
> >> Best,
> >> Chenyuan
> > 
> > Hi Hans,
> > 
> > how is the current status of this bug fix?  It seems that the thread
> > stalled, and I wonder how we can go further.
> > 
> > I'm asking it because CVE-2024-23848 was assigned and we've been asked
> > about the bug fix.
> 
> I missed this reply, so I will take another look at the patch. Too many emails :-(
> 
> Two other patches relating to this I have just posted:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/2b043325-14c0-4e63-ae9c-0d685d96fd98@xs4all.nl/
> https://patchwork.linuxtv.org/project/linux-media/patch/f17f961b-3a19-48da-941a-c8970d9e1786@xs4all.nl/

Thanks!  If a full set of patches are ready, please let us know.


Takashi

> 
> Regards,
> 
> 	Hans
> 
> > 
> > 
> > Thanks!
> > 
> > Takashi
> > 
> >>
> >> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> >> Date: Friday, February 23, 2024 at 8:44 AM
> >> To: Yang, Chenyuan <cy54@illinois.edu>, linux-media@vger.kernel.org <linux-media@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> >> Cc: jani.nikula@intel.com <jani.nikula@intel.com>, syzkaller@googlegroups.com <syzkaller@googlegroups.com>, mchehab@kernel.org <mchehab@kernel.org>, Zhao, Zijie <zijie4@illinois.edu>, Zhang, Lingming <lingming@illinois.edu>
> >> Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
> >> Hi Chenyuan,
> >>
> >> Here is another patch for you to try. I think it is good for blocking CEC_ADAP_S_LOG_ADDRS
> >> ioctl calls, but if the filehandle is in non-blocking mode, I'm still not certain it
> >> is correct. But one issue at a time :-)
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
> >> index 559a172ebc6c..a493cbce2456 100644
> >> --- a/drivers/media/cec/core/cec-adap.c
> >> +++ b/drivers/media/cec/core/cec-adap.c
> >> @@ -936,8 +936,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
> >>           */
> >>          mutex_unlock(&adap->lock);
> >>          wait_for_completion_killable(&data->c);
> >> -       if (!data->completed)
> >> -               cancel_delayed_work_sync(&data->work);
> >> +       cancel_delayed_work_sync(&data->work);
> >>          mutex_lock(&adap->lock);
> >>
> >>          /* Cancel the transmit if it was interrupted */
> >> @@ -1575,9 +1574,12 @@ static int cec_config_thread_func(void *arg)
> >>   */
> >>  static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
> >>  {
> >> -       if (WARN_ON(adap->is_configuring || adap->is_configured))
> >> +       if (WARN_ON(adap->is_claiming_log_addrs ||
> >> +                   adap->is_configuring || adap->is_configured))
> >>                  return;
> >>
> >> +       adap->is_claiming_log_addrs = true;
> >> +
> >>          init_completion(&adap->config_completion);
> >>
> >>          /* Ready to kick off the thread */
> >> @@ -1592,6 +1594,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
> >>                  wait_for_completion(&adap->config_completion);
> >>                  mutex_lock(&adap->lock);
> >>          }
> >> +       adap->is_claiming_log_addrs = false;
> >>  }
> >>
> >>  /*
> >> diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
> >> index 67dc79ef1705..3ef915344304 100644
> >> --- a/drivers/media/cec/core/cec-api.c
> >> +++ b/drivers/media/cec/core/cec-api.c
> >> @@ -178,7 +178,7 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
> >>                             CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
> >>                             CEC_LOG_ADDRS_FL_CDC_ONLY;
> >>          mutex_lock(&adap->lock);
> >> -       if (!adap->is_configuring &&
> >> +       if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
> >>              (!log_addrs.num_log_addrs || !adap->is_configured) &&
> >>              !cec_is_busy(adap, fh)) {
> >>                  err = __cec_s_log_addrs(adap, &log_addrs, block);
> >> @@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
> >>                  list_del_init(&data->xfer_list);
> >>          }
> >>          mutex_unlock(&adap->lock);
> >> +
> >> +       mutex_lock(&fh->lock);
> >>          while (!list_empty(&fh->msgs)) {
> >>                  struct cec_msg_entry *entry =
> >>                          list_first_entry(&fh->msgs, struct cec_msg_entry, list);
> >> @@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
> >>                          kfree(entry);
> >>                  }
> >>          }
> >> +       mutex_unlock(&fh->lock);
> >>          kfree(fh);
> >>
> >>          cec_put_device(devnode);
> >> diff --git a/include/media/cec.h b/include/media/cec.h
> >> index 10c9cf6058b7..cc3fcd0496c3 100644
> >> --- a/include/media/cec.h
> >> +++ b/include/media/cec.h
> >> @@ -258,6 +258,7 @@ struct cec_adapter {
> >>          u16 phys_addr;
> >>          bool needs_hpd;
> >>          bool is_enabled;
> >> +       bool is_claiming_log_addrs;
> >>          bool is_configuring;
> >>          bool must_reconfigure;
> >>          bool is_configured;
> >>
> 

