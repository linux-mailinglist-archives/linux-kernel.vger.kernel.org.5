Return-Path: <linux-kernel+bounces-83305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D783386919D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151441C27E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8144C13B79F;
	Tue, 27 Feb 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yx6oiN+s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3w+Qj6AJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yx6oiN+s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3w+Qj6AJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620713B2A2;
	Tue, 27 Feb 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039936; cv=none; b=BuPZUNq0U0aL94SWOjGS4P3vmeLf4leoNbKJRpFOFjx3SRq7Lnh2Xq7A7xFl+qtOHuti/EFYjpwjzH7L41C3Jhsc/FeaiP0oYGPRQ7DohMutP2vXArxZQRiYzl6nCfKw4LAliA9aFnvg19karYQiwNPAydoTKYg5gNLn0EY2H2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039936; c=relaxed/simple;
	bh=tYd0vCp6AbOyJoSfA2zmRq/u0mLMoAJKm0UC99IduH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbOkluWYBYkqqpKJi3NZm/cOlg+d2kWbzPjcQ8iycWotHZ+/MMhbQ/bp8QZ3SX7dlmrqYxt6cG1YOLcwTyYbX/OaG6jdAgU3TevzZ1yYeR/6YQ1Oa7+doA3i4Y5H4C+Itvtx8DLUufmMbGRkPVCxWMMCt08PfKRL96pvCEiGGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yx6oiN+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3w+Qj6AJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yx6oiN+s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3w+Qj6AJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9551222B1;
	Tue, 27 Feb 2024 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709039933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIlOSV0TQNSPsr1l71Sd7x8euobQck9HznkmkrefATM=;
	b=yx6oiN+sMijyaPYzbp0Rej2X7EhWR2PcWGeWvw0NYeO/OexSzyP3GOILQih5OrmBXhhvp8
	PaV8DkIHBoyR9T45X8tdhXKgvMFTWvHnsZq0oil8JtUVV9PriFVLk5XlH/hz8cRF7D4uhb
	r1AYB+aUsyPOh6mbKM9nZblV8fKuNmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709039933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIlOSV0TQNSPsr1l71Sd7x8euobQck9HznkmkrefATM=;
	b=3w+Qj6AJm/UpKPmBO/3E8WUGUHQXKw4qny4WDEH6OR2otvFUUsSPS4z36zstCAZ0+Bvnyn
	JxAq8SEXS+lhHlCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709039933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIlOSV0TQNSPsr1l71Sd7x8euobQck9HznkmkrefATM=;
	b=yx6oiN+sMijyaPYzbp0Rej2X7EhWR2PcWGeWvw0NYeO/OexSzyP3GOILQih5OrmBXhhvp8
	PaV8DkIHBoyR9T45X8tdhXKgvMFTWvHnsZq0oil8JtUVV9PriFVLk5XlH/hz8cRF7D4uhb
	r1AYB+aUsyPOh6mbKM9nZblV8fKuNmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709039933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIlOSV0TQNSPsr1l71Sd7x8euobQck9HznkmkrefATM=;
	b=3w+Qj6AJm/UpKPmBO/3E8WUGUHQXKw4qny4WDEH6OR2otvFUUsSPS4z36zstCAZ0+Bvnyn
	JxAq8SEXS+lhHlCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 95FB313419;
	Tue, 27 Feb 2024 13:18:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OiUAITzh3WVmagAAn2gu4w
	(envelope-from <clopez@suse.de>); Tue, 27 Feb 2024 13:18:52 +0000
Message-ID: <084e7c38-ebce-4091-af40-42283e344ccc@suse.de>
Date: Tue, 27 Feb 2024 14:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Content-Language: en-US
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024022544-CVE-2023-52466-fea5@gregkh>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
In-Reply-To: <2024022544-CVE-2023-52466-fea5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.15
X-Spamd-Result: default: False [-2.15 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.975];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.87)[85.61%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO


Hi,

On 25/2/24 9:16, Greg Kroah-Hartman wrote:
> There is no actual issue right now because we have another check afterwards
> and the out-of-bounds read is not being performed. In any case it's better
> code with this fixed, hence the proposed change.

Given that there is no actual security issue this looks more like a
hardening, and thus not deserving of a CVE, no?

Best,
Carlos

-- 
Carlos López
Security Engineer
SUSE Software Solutions

