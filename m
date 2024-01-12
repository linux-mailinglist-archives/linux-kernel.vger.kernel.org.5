Return-Path: <linux-kernel+bounces-24854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA72482C376
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D3C28528B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC2745C4;
	Fri, 12 Jan 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PJAqNi7I"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCE745C8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28d61ba65eso779495166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705076371; x=1705681171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDDXOrGKGTJblIZWpACZumqt1y5bURMC1yXwUHMOYmM=;
        b=PJAqNi7I6OtNwnv/IIEVQdY3PJpWxRj4wpDpqUlY6WZh/qBbPRMmFpjwmAj7ar+r8V
         BCrsqHgZTBIlHrlHmC5OeZ7iCMszHAAeuCkW29rG/Em6XgLRN71ctc185MLB+7EWI2b6
         9k5onsHhHK9tXw0csjCkG/GEh9ERzlMxzzOtTDqYinAVNyxM4pUA1/bbxetrLYCTdf55
         cso3zUHwPYpOYLJvWCM3xoNJeb7b5KewH2Fl7zbOsO0O6nK0yGzO4RpX/CWs5wn3g6P9
         0SUnv64yDwdVPShj3tvXz4h7HxNRtN5P9mr4Apy6HFZT0TZK81rNVQU17c53nX8MvAk3
         636w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076371; x=1705681171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDDXOrGKGTJblIZWpACZumqt1y5bURMC1yXwUHMOYmM=;
        b=MPBG97qqPEdMzI/arh+6WWkNY7QqnfcvASqm1qHOxh4x4pm+pDwucDtxLGFsOEvQxM
         A71FLDjFTlKEfaylYmzVJkdBhoyD+jKjC0YzdASs36EDc3au0ovnqZwMioaliGHaDj2/
         6uSpXwMfKN9hK/sbGUBbxgVVeONQq/WFpAdlAUY+4AB0naJvEC9s0s6OJExp3hTDiGrq
         CuRx1uMku72adH77fFmCXuaYWY39atkkUoeuKY74Z9GBzpMSKX45EjbrciHn4qQS3Bpn
         zZIoFeT/vcXBSZ4ml4cEHWgtkgAIo+geJ+Zm6hAwe9XJh+AJsiT5JpC7HgKsZ5twl6n/
         VzZQ==
X-Gm-Message-State: AOJu0YxMkuB0buejmuBJx7sdLrZeftqCozWtRhuC7/X0Mxt+9oVXgJ1T
	4hMhkuKsphForvm2A4kV1vYqWOyKrmWppw==
X-Google-Smtp-Source: AGHT+IGMjBdjy7LOzpbgL5yBIMdMRI3aXf+g2U+wZduGKLtcXafAxywnh3ixlisbZyGGh9Z5pBZvRQ==
X-Received: by 2002:a17:907:914e:b0:a2c:36f:d59a with SMTP id l14-20020a170907914e00b00a2c036fd59amr452718ejs.61.1705076371537;
        Fri, 12 Jan 2024 08:19:31 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id gw23-20020a170906f15700b00a2b09bfb648sm1956355ejb.5.2024.01.12.08.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 08:19:31 -0800 (PST)
Date: Fri, 12 Jan 2024 17:19:29 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 03/14] printk: Use prb_first_seq() as base for
 32bit seq macros
Message-ID: <ZaFmkY3QElF_Oemw@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-4-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:50, John Ogness wrote:
> Note: This change only applies to 32bit architectures. On 64bit
>       architectures the macros are NOPs.
> 
> Currently prb_next_seq() is used as the base for the 32bit seq
> macros __u64seq_to_ulseq() and __ulseq_to_u64seq(). However, in
> a follow-up commit, prb_next_seq() will need to make use of the
> 32bit seq macros.
> 
> Use prb_first_seq() as the base for the 32bit seq macros instead
> because it is guaranteed to return 64bit sequence numbers without
> relying on any 32bit seq macros.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

This increases the risk of an overflow which would result
into wrong u64 sequence number. I was curious what numbers
we are talking about.

Here is my thinking:

The difference between prb_next_seq() and prb_first_seq() is
limited by the amount of messages stored in the buffer.

Every stored message must have meta data stored in desc_ring.
The current code expects average length of the message to be 32.

Now, __ulseq_to_u64seq() would give wrong result when
(s32)((u32)rb_first_seq - ulseq) overflows. It is 2^31
sequence numbers.

If we create desc buffer for these messages then the
data buffer would be 32x bigger, so:

   2^31 * 32 = 68,719,476,736 => 68GB

=> we seem to be on the safe side with a good reserve.


Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

