Return-Path: <linux-kernel+bounces-68213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BCD857756
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F12E282ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FB31DDF1;
	Fri, 16 Feb 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QEdyB/lG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fmu3FUXo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A017C7F;
	Fri, 16 Feb 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070696; cv=none; b=NLQ89F1y/9V52CA9f9VvLPfAzp1xP1ozj+Mf/qUFR+trZwphNpZSZ9N6vuK7C3F8go7c1dd+Oiowx5CnHdMGy99oUJIC4zqKMo9OsMz5X5z54/FksKnP9mjDxZteLRvWGCyORAYAjZOvgBFI5R/x64QyFEgdXuftOyUTyZ+nIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070696; c=relaxed/simple;
	bh=6IcxGgQ6KhP2QolO3Y7TmheTe+h1XES9Kzd919zh5Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rym1xpZwgWr0VJ0BAiPFAdgQr7y4F6PTnGNDa2b2nBcxDM63Kg1iXQZQkiq6+RxYDrgpVad8th/7D30OH5R5ptVNj8F8huS3JekKDpTe+C3+apQMXdyIAE4uoJKdEkctZdiQEf8YfQPLdm52Bf6v/4Fi2WoSEYwowwnPb0jt1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QEdyB/lG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fmu3FUXo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E221D21FC8;
	Fri, 16 Feb 2024 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708070646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4morDVMYuFmPhrSEse/hUV+Yz8JfX8TaTSr9hmBxFI=;
	b=QEdyB/lGeuxHG0U5scwLIc9Cj1bx3qqH1rT/lVZxpjggc+KalZugeSHFuZ2tFZuYF6THB7
	itInW+zh4gQM+7FVBKcPmi3hAxuPFcI/SXCGs6OjOuJXpdIiIkQah8RRdgFFdDqBYWobQB
	0XA37rzcFzq9aLw5ncXqmSVOQvfFV+E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708070643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4morDVMYuFmPhrSEse/hUV+Yz8JfX8TaTSr9hmBxFI=;
	b=fmu3FUXoyo7eLHfudWqM3JlOzgsOdU4WrVMJiJmU+j1+t8D6d4fgLE4c2/CdHeA5aIEXmM
	qD14hzVEnwqChB91PhRJmo2dXe+NLp0sgbxpTA2kHQw7QFsyqLd4M39bVSdLCzqqSkpbAJ
	kmnvTIgZmsl/TKRPmLY1I1R4AVKGoTU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7451F1398D;
	Fri, 16 Feb 2024 08:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0ntWGvMWz2WgWAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 16 Feb 2024 08:04:03 +0000
Message-ID: <a2ccf959-2b43-4a9d-9b7d-77122670b090@suse.com>
Date: Fri, 16 Feb 2024 09:04:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE process
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, linux@leemhuis.info,
 Kees Cook <keescook@chromium.org>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sasha Levin <sashal@kernel.org>,
 Lee Jones <lee@kernel.org>, "Xen.org security team" <security@xen.org>
References: <2024021500-laziness-grimace-ed80@gregkh>
 <0bd8c620-7f80-44c4-ade3-b3d7951b48d8@suse.com>
 <2024021557-remedial-mutilated-63c6@gregkh>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <2024021557-remedial-mutilated-63c6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fmu3FUXo
X-Spamd-Result: default: False [-0.97 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLnj7krbkygzjkra4c7ii5ombr)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.83)[subject];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[lwn.net,vger.kernel.org,kernel.org,leemhuis.info,chromium.org,linuxfoundation.org,gmail.com,xen.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.97
X-Rspamd-Queue-Id: E221D21FC8
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On 15.02.24 18:49, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2024 at 04:03:02PM +0100, Jürgen Groß wrote:
>> On 15.02.24 13:10, Greg Kroah-Hartman wrote:
>>> The Linux kernel project now has the ability to assign CVEs to fixed
>>> issues, so document the process and how individual developers can get a
>>> CVE if one is not automatically assigned for their fixes.
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>> Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>> ---
>>> v4: Add MAINTAINER entry
>>>       Lots of tiny wording changes based on many reviews
>>>       Collected some Reviewed-by: tags
>>>       Fixed documenation build by properly referencing the security
>>>       process documentation file.
>>> v3: fix up wording in security-bugs.rst based on the changes to the cve
>>>       assignment process from v1, thanks to a private reviewer for
>>>       pointing that out.
>>> v2: Grammer fixes based on review from Randy
>>>       Updated paragraph about how CVE identifiers will be assigned
>>>       (automatically when added to stable trees, or ask us for one
>>>       directly before that happens if so desired)
>>>
>>>    Documentation/process/cve.rst           | 120 ++++++++++++++++++++++++
>>>    Documentation/process/index.rst         |   1 +
>>>    Documentation/process/security-bugs.rst |   5 +-
>>>    MAINTAINERS                             |   5 +
>>>    4 files changed, 128 insertions(+), 3 deletions(-)
>>>    create mode 100644 Documentation/process/cve.rst
>>>
>>> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
>>> new file mode 100644
>>> index 000000000000..6b244d938694
>>> --- /dev/null
>>> +++ b/Documentation/process/cve.rst
>>> @@ -0,0 +1,120 @@
>>
>> ...
>>
>>> +Invalid CVEs
>>> +------------
>>> +
>>> +If a security issue is found in a Linux kernel that is only supported by
>>> +a Linux distribution due to the changes that have been made by that
>>> +distribution, or due to the distribution supporting a kernel version
>>> +that is no longer one of the kernel.org supported releases, then a CVE
>>> +can not be assigned by the Linux kernel CVE team, and must be asked for
>>> +from that Linux distribution itself.
>>> +
>>> +Any CVE that is assigned against the Linux kernel for an actively
>>> +supported kernel version, by any group other than the kernel assignment
>>> +CVE team should not be treated as a valid CVE.  Please notify the
>>> +kernel CVE assignment team at <cve@kernel.org> so that they can work to
>>> +invalidate such entries through the CNA remediation process.
>>
>> Today we (the Xen security team) are allocating CVEs for Xen-related
>> kernel security bugs.
>>
>> Does this mean we should do that via cve@kernel.org in future, or are
>> you happy us continuing our process as today? If the latter, I think
>> this should be noted somehow in this document in order to avoid complaints
>> regarding CVEs allocated by us.
>>
>>
>> Juergen (on behalf of the Xen security team)
> 
> That's a good question, and from what I can tell for the "rules" here,
> yes, we need to coordinate somehow for anything that is Linux
> kernel-only.  Just email us and ask us for an id and our tools can take
> it from there for the submission and other stuff, so hopefully this will
> make things easier.

Okay, thanks, noted.

> For stuff that crosses both sides (Xen and Linux), you are free to
> create your own CVE and then use that identifier in the kernel patch
> like you have in the past as I would consider Xen being the "primary"
> CNA, don't you?

We didn't have this case so far, and I think we'd just have one CVE for Xen
and one for Linux. Nevertheless good to know should this case ever come up.

> Is that ok?  We want to make this as easy as possible, so I don't want
> to get in the way of your existing process if at all possible.

Yes, thanks, this is okay. Just wanted to have it spelled out. :-)


Juergen

