Return-Path: <linux-kernel+bounces-1518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E7814F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6731F23225
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB430135;
	Fri, 15 Dec 2023 18:20:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F63011A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:41064)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rECGj-00CCA6-Dn; Fri, 15 Dec 2023 10:46:37 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:50734 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rECGi-00CJs3-Ex; Fri, 15 Dec 2023 10:46:37 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  x86@kernel.org,  Andrew Morton <akpm@linux-foundation.org>,  Thomas
 Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav
 Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,  "H.
 Peter Anvin" <hpa@zytor.com>,  Jonathan Corbet <corbet@lwn.net>
References: <20231215080910.173338-1-ytcoode@gmail.com>
	<20231215080910.173338-2-ytcoode@gmail.com>
Date: Fri, 15 Dec 2023 11:46:28 -0600
In-Reply-To: <20231215080910.173338-2-ytcoode@gmail.com> (Yuntao Wang's
	message of "Fri, 15 Dec 2023 16:09:08 +0800")
Message-ID: <87a5qb4avf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rECGi-00CJs3-Ex;;;mid=<87a5qb4avf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX189yCEqcjYR5MZGxwEuoh60iLC+05tSlWI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: ***
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  1.0 T_XMDrugObfuBody_00 obfuscated drug references
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Yuntao Wang <ytcoode@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 398 ms - load_scoreonly_sql: 0.10 (0.0%),
	signal_user_changed: 12 (3.0%), b_tie_ro: 10 (2.5%), parse: 1.08
	(0.3%), extract_message_metadata: 3.9 (1.0%), get_uri_detail_list:
	1.33 (0.3%), tests_pri_-2000: 3.9 (1.0%), tests_pri_-1000: 2.9 (0.7%),
	tests_pri_-950: 1.34 (0.3%), tests_pri_-900: 1.06 (0.3%),
	tests_pri_-90: 91 (22.9%), check_bayes: 89 (22.3%), b_tokenize: 7
	(1.7%), b_tok_get_all: 6 (1.5%), b_comp_prob: 2.3 (0.6%),
	b_tok_touch_all: 69 (17.4%), b_finish: 1.54 (0.4%), tests_pri_0: 262
	(65.8%), check_dkim_signature: 0.81 (0.2%), check_dkim_adsp: 2.9
	(0.7%), poll_dns_idle: 0.58 (0.1%), tests_pri_10: 2.2 (0.5%),
	tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] kexec_file: fix incorrect end value passed to
 kimage_is_destination_range()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Yuntao Wang <ytcoode@gmail.com> writes:

> The end parameter received by kimage_is_destination_range() should be the
> last valid byte address of the target memory segment plus 1. However, in
> the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
> the corresponding value passed to kimage_is_destination_range() is the last
> valid byte address of the target memory segment, which is 1 less. Fix
> it.

If that is true we I think we should rather fix
kimage_is_destination_range.

Otherwise we run the risk of having areas whose end is not
representable, epecially on 32bit.


Eric


> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/kexec_file.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f9a419cd22d4..26be070d3bdd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -435,13 +435,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  		if (temp_start < start || temp_start < kbuf->buf_min)
>  			return 0;
>  
> -		temp_end = temp_start + kbuf->memsz - 1;
> -
>  		/*
>  		 * Make sure this does not conflict with any of existing
>  		 * segments
>  		 */
> -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> +		if (kimage_is_destination_range(image, temp_start,
> +						temp_start + kbuf->memsz)) {
>  			temp_start = temp_start - PAGE_SIZE;
>  			continue;
>  		}
> @@ -475,7 +474,7 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  		 * Make sure this does not conflict with any of existing
>  		 * segments
>  		 */
> -		if (kimage_is_destination_range(image, temp_start, temp_end)) {
> +		if (kimage_is_destination_range(image, temp_start, temp_end + 1)) {
>  			temp_start = temp_start + PAGE_SIZE;
>  			continue;
>  		}

