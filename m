Return-Path: <linux-kernel+bounces-52594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96C849A21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BC71F24FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BD1BC4C;
	Mon,  5 Feb 2024 12:28:07 +0000 (UTC)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AFF1BC2F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136086; cv=none; b=A4rhsRjTaQfmhY6F+DUEVCX3RNnFLlzshqQuPTiwEMzkUhHZ+vYIsGB5rvEQVMgL3TiwTvbJPi9RYOzSxOwOA1/k6lD7/NzN3CIq+ey865RveE1N2zY4TTr8jOhPJye6pwDvW2VVg3f2LjX+qOYEkTMu3xGvSSZ8ChdmcWFVj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136086; c=relaxed/simple;
	bh=ZjFkFrh7H6qRtcI5B4RLdZ4S6rWhJ+vkg885iyHjhF8=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Yp8u9bJlJupB9JILoAEnDOkfbqOnsn2FEPpeKbJXYMobFXIPHP9OGtPfHihZq9hPiphTslRlW1YtgwLSPLd3gbFaf3FmbJn0uWhL1uqlEII2k0+YLaZwCJWlX6yoM2227PwwRnTwb5w2DR5f/prv5RDEbNM+tBYXTAT3Z8rxQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:49462)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rWy4q-00A381-UM; Mon, 05 Feb 2024 05:27:56 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54108 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rWy4p-0050ZB-Pj; Mon, 05 Feb 2024 05:27:56 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Baoquan He <bhe@redhat.com>
Cc: "yang.zhang" <gaoshanliukou@163.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  "yang.zhang" <yang.zhang@hexintek.com>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
	<Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
Date: Mon, 05 Feb 2024 06:27:33 -0600
In-Reply-To: <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv> (Baoquan He's message of "Sun,
	4 Feb 2024 15:38:26 +0800")
Message-ID: <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rWy4p-0050ZB-Pj;;;mid=<871q9r3xl6.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/FgnfPR7m0NTTwj+9KpVfyCvCURxVFUjo=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Baoquan He <bhe@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 545 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 13 (2.4%), b_tie_ro: 12 (2.1%), parse: 0.88
	(0.2%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 1.61
	(0.3%), tests_pri_-2000: 4.6 (0.8%), tests_pri_-1000: 2.3 (0.4%),
	tests_pri_-950: 1.19 (0.2%), tests_pri_-900: 0.96 (0.2%),
	tests_pri_-90: 74 (13.6%), check_bayes: 73 (13.4%), b_tokenize: 7
	(1.3%), b_tok_get_all: 5 (1.0%), b_comp_prob: 2.1 (0.4%),
	b_tok_touch_all: 55 (10.1%), b_finish: 0.93 (0.2%), tests_pri_0: 249
	(45.7%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 2.7
	(0.5%), poll_dns_idle: 156 (28.5%), tests_pri_10: 2.1 (0.4%),
	tests_pri_500: 182 (33.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec: should use uchunk for user buffer increasing
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Baoquan He <bhe@redhat.com> writes:

> On 01/30/24 at 06:18pm, yang.zhang wrote:
>> From: "yang.zhang" <yang.zhang@hexintek.com>
>> 
>> Because of alignment requirement in kexec-tools, there is
>> no problem for user buffer increasing when loading segments.
>> But when coping, the step is uchunk, so we should use uchunk
>> not mchunk.
>
> In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
> is exhausted, while there's still remaining mbytes, then uchunk is 0,
> there's still mchunk stepping forward. If I understand it correctly,
> this is a good catch. Not sure if Eric has comment on this to confirm.

As far as I can read the code the proposed change is a noop.

I agree it is more correct to not advance the pointers we read from,
but since we never read from them after that point it does not
matter.

>
> static int kimage_load_normal_segment(struct kimage *image,
>                                          struct kexec_segment *segment)
> {
> ......
>
>                 ptr += maddr & ~PAGE_MASK;
>                 mchunk = min_t(size_t, mbytes,
>                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
>                 uchunk = min(ubytes, mchunk);
> ......}

If we are going to improve the code for clarity.  We probably
want to do something like:

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d08fc7b5db97..1a8b8ce6bf15 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
                                PAGE_SIZE - (maddr & ~PAGE_MASK));
                uchunk = min(ubytes, mchunk);
 
-               /* For file based kexec, source pages are in kernel memory */
-               if (image->file_mode)
-                       memcpy(ptr, kbuf, uchunk);
-               else
-                       result = copy_from_user(ptr, buf, uchunk);
+               if (uchunk) {
+                       /* For file based kexec, source pages are in kernel memory */
+                       if (image->file_mode)
+                               memcpy(ptr, kbuf, uchunk);
+                       else
+                               result = copy_from_user(ptr, buf, uchunk);
+                       ubytes -= uchunk;
+                       if (image->file_mode)
+                               kbuf += uchunk;
+                       else
+                               buf += uchunk;
+               }
                kunmap_local(ptr);
                if (result) {
                        result = -EFAULT;
                        goto out;
                }
-               ubytes -= uchunk;
                maddr  += mchunk;
-               if (image->file_mode)
-                       kbuf += mchunk;
-               else
-                       buf += mchunk;
                mbytes -= mchunk;
 
                cond_resched();

And make it exceedingly clear that all of the copying and the rest
only happens before uchunk goes to zero.  Otherwise we are relying
on a lot of operations becoming noops when uchunk goes to zero.

Eric

