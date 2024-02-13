Return-Path: <linux-kernel+bounces-63401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1EC852ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D1E1F26F12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FABD33CD2;
	Tue, 13 Feb 2024 11:12:13 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CE2BD1C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822732; cv=none; b=Uewy6cp/2jV0z57mMX2O0B1cgH4je2WDitRljW2Ay5Pw4Jk8AwAvWKk/QY3W2KdcaBFEgI6VKfjMotZM1vDXNYYR4Y2trOjgO4nwjHfWfKlPKfKaTJt5IQBQWmU87hV/uLlC8M+WaTXwTz/saohwGRAnfXsDZHi8UwkdPn1TXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822732; c=relaxed/simple;
	bh=ml6DaSPAgvx0MDCXLVrcM13BtnghxuN6dJ1Og0NPY2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeVFuHW23MBek+4kbMR9uZNeVYFyDJbG1h+AnTXa3q5dzAFGf8Tnl2EukrpJG4ojQWO3sDkYWphR5EvwswRdMwh20XxXo4zs53z7MF8QhcRMtbH33fKdns2AcYIeiSEN3HqVHbTdNIyzl3OuCSmLHiU3UQnasNTV2PlLugKb3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 628A01FC81;
	Tue, 13 Feb 2024 11:12:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EB2813404;
	Tue, 13 Feb 2024 11:12:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gy/cEolOy2VKdAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Feb 2024 11:12:09 +0000
Message-ID: <8e432cce-d5c9-45f2-bba9-6add1453a01d@suse.cz>
Date: Tue, 13 Feb 2024 12:12:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] lib/stackdepot: Move stack_record struct
 definition into the header
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-2-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240212223029.30769-2-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 628A01FC81
X-Spam-Flag: NO

On 2/12/24 23:30, Oscar Salvador wrote:
> In order to move the heavy lifting into page_owner code, this one
> needs to have access to the stack_record structure, which right now
> sits in lib/stackdepot.c.
> Move it to the stackdepot.h header so page_owner can access
> stack_record's struct fields.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


