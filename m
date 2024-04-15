Return-Path: <linux-kernel+bounces-145219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC758A5101
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD4DBB22F54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86542762CD;
	Mon, 15 Apr 2024 13:04:58 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFD76057
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186298; cv=none; b=utXdXnx1WArIIz196DGsP0stXarsUbxIE+ieIXmbCatpHVdM8dmvmZeNSjN70kucpuM2MyC3qBznpEy7qt0vgJRwNI7qvhEfj2akcfvHCzuDeC9btb5vimgUh8y8aUQjNDcyXCk2Cg9F7Z25r0V5medFlNKibrXmGA7cM2RyjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186298; c=relaxed/simple;
	bh=PbmSS4iAYWEISocJ9w+PkOJnKbBzbsLh++RX1AZOWV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEh2i/iY2tiEGyhkFxKma1ZKnS/QhVjn7fq2aU3ivCsHIwE5/YUMyzSgC+FBLl16re1mPQBdEEnsz0iR+anBv86QrpAk80+XLk5AcMu0owwmb05R9By0WTBn2TFbGRmsPJO95j0xqSlDWD7wG//U7C9kKYfcWULngTXEmh/ZjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43FD4VMn055643;
	Mon, 15 Apr 2024 22:04:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Mon, 15 Apr 2024 22:04:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43FD4Va5055640
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Apr 2024 22:04:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
Date: Mon, 15 Apr 2024 22:04:31 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kpsingh:static_calls] [security] 9e15595ed0:
 Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
To: KP Singh <kpsingh@kernel.org>, kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <202404151225.ce542e38-lkp@intel.com>
 <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/15 17:26, KP Singh wrote:
> This seems like an odd config which does not enable STATIC_CALL, I am going to
> make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the dependency explicit.

If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures which do not
support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a bad dependency.


