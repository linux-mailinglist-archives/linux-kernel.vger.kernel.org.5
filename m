Return-Path: <linux-kernel+bounces-151606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D038AB10E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D341F247C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF112F38B;
	Fri, 19 Apr 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eQe8if3j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z67OzjRn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FYzHrNhW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wNGssJt/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8FC7E11E;
	Fri, 19 Apr 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538288; cv=none; b=niUPrghvxHzPAdEMyqSmDh4sGbLlB7a3ssg7P2iJwuQ5G4NN+SrVt2DfedazywIhAMWo+tOLfp4NJxQYARcQQu0wuTIhEsGzXCRDIE1Or3g21M18TWfmviF0GiEHXXBjrYgcN7X5JNqGXjsJBq1N0By3gU/qMddvPWUgrx82POI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538288; c=relaxed/simple;
	bh=T8CLr1EK+PL03WYbPidGaQUkxWlf+IiGWcm14wkF5SA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0FXjIxnCxFxcxIG/7gUSmM6o7kCPwBHDFQsm/E0iGnwW/uaZKbmHD+gFsuKERbtER34HlI9Pcm4PyUuGHZrSQeOQnN5ia9tN5M7lO4eqloV+uhOl4OcskPzz2ip0SZ0O20oRUV3ystoe2/j5gB3F/iXq6S6ZdvIBRYk7wGILTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eQe8if3j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z67OzjRn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FYzHrNhW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wNGssJt/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E09883788F;
	Fri, 19 Apr 2024 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713538279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIkR9gPm5JkJwOvVohQpNqV/QJ9qSICPkeseQbgyIG8=;
	b=eQe8if3jSFmjI5hEY7POoZ9u+dUvStqmZhEl1GhL1FpEPFjsn/dhn3DLKA01GqmD2r/Ylc
	GKwePO8821z/JM1dCgalKgJXbE00m/g4tOgWV0SyGD/jvmlVWezIbQSW0JOfEeBrpaN13F
	UKK6wekqQ7KA3nYy4jIDgB6fhwDH4CM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713538279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIkR9gPm5JkJwOvVohQpNqV/QJ9qSICPkeseQbgyIG8=;
	b=z67OzjRnq4EGu+xWYdDGP8VPRI2aPR+XZr5nwrTkLX20+YyPzmMZZyjj+nIFaj1XKO07Z1
	BNKBSCuxfpBaSxCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713538277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIkR9gPm5JkJwOvVohQpNqV/QJ9qSICPkeseQbgyIG8=;
	b=FYzHrNhWPZZV+GqsP83bdyP1IYWc08YShDUKoY0+7W5V7n1EJk++2SccwN1NKGEOPiqxuo
	3Q2a/IQqQEzKmwlPIDQ2UUBzszgdu1tqvKsyT+n6bmtjUs/RYZzFzhRIgBkdRQqGN/rAvg
	cnLgobbdfbDRFG2tWQZVbHRIWtmdk8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713538277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIkR9gPm5JkJwOvVohQpNqV/QJ9qSICPkeseQbgyIG8=;
	b=wNGssJt/rj8gApzi2Gonmi5itxCtIvfpovfbV6xSvLe2t4G5ovY4MI+VTmragzQOBosWuJ
	ZPhcfboAqi4if4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C51113687;
	Fri, 19 Apr 2024 14:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ogjuJOWEImYudAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Apr 2024 14:51:17 +0000
Date: Fri, 19 Apr 2024 16:51:25 +0200
Message-ID: <87le59s8wi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: "Yang, Chenyuan" <cy54@illinois.edu>,
	"linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"jani.nikula@intel.com" <jani.nikula@intel.com>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"Zhao, Zijie"
	<zijie4@illinois.edu>,
	"Zhang, Lingming" <lingming@illinois.edu>
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
In-Reply-To: <7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
	<f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
	<526380BE-57AC-493D-A7B0-B8F0ECC0FE0A@illinois.edu>
	<f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
	<2e5f1e92-7fad-4a74-b375-1e194ff08ce6@xs4all.nl>
	<F8D4A291-8CFB-4A25-B296-3CA07B56F459@illinois.edu>
	<49a68c10-9549-4fd8-b929-d4c7a9c8debf@xs4all.nl>
	<PH7PR11MB5768B0BC3C042A6EA4EC1EF0A0542@PH7PR11MB5768.namprd11.prod.outlook.com>
	<7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
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
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,xs4all.nl:email,intel.com:email,illinois.edu:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 26 Feb 2024 13:27:16 +0100,
Yang, Chenyuan wrote:
> 
> Hi Hans,
> 
> Thank you for your continued efforts in investigating this bug and implementing the new patch!
> 
> Regarding the two warnings, they have been addressed by this new patch and are no longer reproducible. Additionally, I conducted a 48-hour fuzzing test on the CEC driver, which has successfully eliminated the previous hanging issue.
> 
> One thing to note that the system will now log timeout events:
> ```
> [ 2281.265385][ T2034] cec-vivid-001-vid-out0: transmit timed out
> [ 2282.994510][ T2017] cec-vivid-000-vid-cap0: transmit timed out
> [ 2283.063484][ T2050] cec-vivid-002-vid-out0: transmit timed out
> [ 2283.073468][ T2065] cec-vivid-003-vid-cap0: transmit timed out
> [ 2283.373518][ T2033] cec-vivid-001-vid-cap0: transmit timed out
> [ 2285.113544][ T2018] cec-vivid-000-vid-out0: transmit timed out
> [ 2285.193502][ T2050] cec-vivid-002-vid-out0: transmit timed out
> [ 2285.193570][ T2065] cec-vivid-003-vid-cap0: transmit timed out
> [ 2285.513570][ T2033] cec-vivid-001-vid-cap0: transmit timed out
> ```
> 
> Best,
> Chenyuan

Hi Hans,

how is the current status of this bug fix?  It seems that the thread
stalled, and I wonder how we can go further.

I'm asking it because CVE-2024-23848 was assigned and we've been asked
about the bug fix.


Thanks!

Takashi

> 
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Date: Friday, February 23, 2024 at 8:44 AM
> To: Yang, Chenyuan <cy54@illinois.edu>, linux-media@vger.kernel.org <linux-media@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Cc: jani.nikula@intel.com <jani.nikula@intel.com>, syzkaller@googlegroups.com <syzkaller@googlegroups.com>, mchehab@kernel.org <mchehab@kernel.org>, Zhao, Zijie <zijie4@illinois.edu>, Zhang, Lingming <lingming@illinois.edu>
> Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
> Hi Chenyuan,
> 
> Here is another patch for you to try. I think it is good for blocking CEC_ADAP_S_LOG_ADDRS
> ioctl calls, but if the filehandle is in non-blocking mode, I'm still not certain it
> is correct. But one issue at a time :-)
> 
> Regards,
> 
>         Hans
> 
> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
> index 559a172ebc6c..a493cbce2456 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -936,8 +936,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
>           */
>          mutex_unlock(&adap->lock);
>          wait_for_completion_killable(&data->c);
> -       if (!data->completed)
> -               cancel_delayed_work_sync(&data->work);
> +       cancel_delayed_work_sync(&data->work);
>          mutex_lock(&adap->lock);
> 
>          /* Cancel the transmit if it was interrupted */
> @@ -1575,9 +1574,12 @@ static int cec_config_thread_func(void *arg)
>   */
>  static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>  {
> -       if (WARN_ON(adap->is_configuring || adap->is_configured))
> +       if (WARN_ON(adap->is_claiming_log_addrs ||
> +                   adap->is_configuring || adap->is_configured))
>                  return;
> 
> +       adap->is_claiming_log_addrs = true;
> +
>          init_completion(&adap->config_completion);
> 
>          /* Ready to kick off the thread */
> @@ -1592,6 +1594,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
>                  wait_for_completion(&adap->config_completion);
>                  mutex_lock(&adap->lock);
>          }
> +       adap->is_claiming_log_addrs = false;
>  }
> 
>  /*
> diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
> index 67dc79ef1705..3ef915344304 100644
> --- a/drivers/media/cec/core/cec-api.c
> +++ b/drivers/media/cec/core/cec-api.c
> @@ -178,7 +178,7 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
>                             CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
>                             CEC_LOG_ADDRS_FL_CDC_ONLY;
>          mutex_lock(&adap->lock);
> -       if (!adap->is_configuring &&
> +       if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
>              (!log_addrs.num_log_addrs || !adap->is_configured) &&
>              !cec_is_busy(adap, fh)) {
>                  err = __cec_s_log_addrs(adap, &log_addrs, block);
> @@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
>                  list_del_init(&data->xfer_list);
>          }
>          mutex_unlock(&adap->lock);
> +
> +       mutex_lock(&fh->lock);
>          while (!list_empty(&fh->msgs)) {
>                  struct cec_msg_entry *entry =
>                          list_first_entry(&fh->msgs, struct cec_msg_entry, list);
> @@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
>                          kfree(entry);
>                  }
>          }
> +       mutex_unlock(&fh->lock);
>          kfree(fh);
> 
>          cec_put_device(devnode);
> diff --git a/include/media/cec.h b/include/media/cec.h
> index 10c9cf6058b7..cc3fcd0496c3 100644
> --- a/include/media/cec.h
> +++ b/include/media/cec.h
> @@ -258,6 +258,7 @@ struct cec_adapter {
>          u16 phys_addr;
>          bool needs_hpd;
>          bool is_enabled;
> +       bool is_claiming_log_addrs;
>          bool is_configuring;
>          bool must_reconfigure;
>          bool is_configured;
> 

