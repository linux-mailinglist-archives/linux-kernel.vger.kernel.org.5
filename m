Return-Path: <linux-kernel+bounces-102667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C6987B57F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CDEAB23E04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1254C5D758;
	Wed, 13 Mar 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf7o9v7I"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573865D907;
	Wed, 13 Mar 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374189; cv=none; b=pB6gS+3b1uT+Rpg/ci6DAXYsMohF2uCmGPQbCx1d37ZpUYdQW+FbDHpyo+q8Hw0kaZ6Sf9ahMXM0Aa+pcdCwqYTsbJwBdkVBLasoIxMGgOxnGmdxd8E/bafXgnAVeliSPK28L1dAdVzEBNzlBlbXbCRsOeei32jxSnSFr2x5seI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374189; c=relaxed/simple;
	bh=2wuwQA5F3GkCIYjVbByx7t+Qk2zD8y++eOTQ4f5SGos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ/1iCIIfu4qXaGjRthcN7Hh+Uy9M2+a2mGlspGw6nYHrV1pGbbqtj2Viauvndi3vbyGN58elqksHdbOdIUK/xnYtiLP3+VL44pOkJV6Qb2Xaw3tE5ReMiXAnNBp3qWhoiWOLmkiAY9FntpZUsq7rhCN3FjqUtcmmywa0gq0vSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf7o9v7I; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so288696276.3;
        Wed, 13 Mar 2024 16:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710374186; x=1710978986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjzW2PldFugsUby30qgzPIiY/kCRzEo44MFkfvCJsv8=;
        b=Cf7o9v7Ij4FWHhLKiWUXNS855yRU5ua20nxvVJFM2W6amk9ghqkTra5zAbkjnea4Ds
         rhqLSAHW/oZcIWXec4ppq/ZcLk5tVrKUA/VzJULqCcy7fvuXH69hDBWGa3W7t/ntzrVC
         xTw+n44xoroWlMTh6BrOXoOjz2s8uYxTTb4JHC2nm3bhLwKqCymWvyhV4I4etnz9ALaI
         F3JFlkUksLZaXKRtYembL28vGq6ZzZrStYfVIt2+xmbBA5X7Js4Tk7LJUpffNxP7b8fA
         /mWKHtkrL7ceoFPCKy0p+VSeW/1C8S3d32lTurgpM0rEnzGoXwtSOtPDe/hHQ9bASGFI
         5H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710374186; x=1710978986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjzW2PldFugsUby30qgzPIiY/kCRzEo44MFkfvCJsv8=;
        b=ovdJUrPT7Z1zFE48XVYMSSvOym1OV7RGytnyEbHwfbulNEDS6DirWwKBCqZqIK6+Y/
         /njEGoLSMEkV7eQB5mY724/ikolpX94kgwoOS11We5SM5WtmF5bGO83EUt09edX9TVdb
         8cWa8BFq+XjIOL/Te+TYszsoGoXOI5LwaMwF34sqyvBfslBQxHYFQDtJ16BhLQ3/ii3j
         lXsNUko2uz4vlVSWjXEY6Sw6c4mN/ek013zYxPTisq8FFRGqaunyvRouHsB5XRw9A+fj
         rVwA6oA625rrMgYiNHEV6ZMISHaB0eymeHI1BoaioULQH/vYiIX8OiDzkd0oMDObKauG
         V6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdaBTFuggZ4Gjf7cNoH4fFSDUOV2O9XfklKt9lbNnEhXsLltMX4xZIloFTMg4T0W600Av14aT4WZpTA+pp5LJYZpUtAFiXu1E+ZQdzia3hqW8/53sdwzR7LekxNyHgXTaWkup2KScvv9cHjwdPdx7xyNlc5bAmZ5BFyC1jIhCT2d1PYxy/cF3P9g==
X-Gm-Message-State: AOJu0YwybLkQjFNv2b1NroCKHC5dBkfrlTBMyhVo/1LlL6/2e2TCdG7D
	UMBhoxymBVpDjjPzQIGO6bkgFhJsu/IqVx1Jh+UkO38BMtYVOM2t
X-Google-Smtp-Source: AGHT+IGPCqzrSaz+ihLMnzkefbDSatKzHAZUcB8ktezTdth/emNchADQbh45o5ZV2n4U09L3+MQ2Dw==
X-Received: by 2002:a25:acc5:0:b0:dcc:8aaa:3ed3 with SMTP id x5-20020a25acc5000000b00dcc8aaa3ed3mr204920ybd.16.1710374186338;
        Wed, 13 Mar 2024 16:56:26 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id s7-20020a0562140ca700b00690b43d39f0sm182358qvs.85.2024.03.13.16.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 16:56:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D2E2F1200068;
	Wed, 13 Mar 2024 19:56:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Mar 2024 19:56:23 -0400
X-ME-Sender: <xms:Jj3yZRvz0GHz7SjlRrmwWwjeI0GBLHCLbxGq1UsDYcHY1nzlkrIebQ>
    <xme:Jj3yZafgOy8Qh16for0Ezl1NMlQGFew4-kIfnOmnNP5OdfyccQXujtugBhVzPKnQl
    C4f_z7Y1ByhxADlow>
X-ME-Received: <xmr:Jj3yZUwJqct9s6kFjelFYFvXsbc9Kk3qr9BbJjkYGUZVQlcEyTcV8_FxF8qd-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedtieeg
    hedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Jj3yZYOpRlTM0KuJjGfuQRIPmkDZt2iuphuSDCh_tFUMxKH5YZzi8g>
    <xmx:Jj3yZR-jaXmX9MkquQ_0juj3rWs9DRHoHiThrm72GGfWGXwcWW5WFw>
    <xmx:Jj3yZYXqAl6QGLjoC5UD9oQJX0o7A5OIVfbdANVZf626rX1EpgITVw>
    <xmx:Jj3yZSfqKqGW1WJHu6dmz8wV25a5xM3eTNlC-2FQazb7jdq8R8myPg>
    <xmx:Jz3yZe4uVi6dhrAR5dVExxsdNG8BEZ8xqwL7uo4TZLA0wbaQmhdnDQpHLeU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 19:56:21 -0400 (EDT)
Date: Wed, 13 Mar 2024 16:55:39 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <ZfI8-14RUqGqoRd-@boqun-archlinux>
References: <20240313110515.70088-1-nmi@metaspace.dk>
 <20240313110515.70088-2-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313110515.70088-2-nmi@metaspace.dk>

On Wed, Mar 13, 2024 at 12:05:08PM +0100, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Add initial abstractions for working with blk-mq.
> 
> This patch is a maintained, refactored subset of code originally published by
> Wedson Almeida Filho <wedsonaf@gmail.com> [1].
> 
> [1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268bbd4382a891/rust/kernel/blk/mq.rs
> 
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  block/blk-mq.c                     |   3 +-
>  include/linux/blk-mq.h             |   1 +
>  rust/bindings/bindings_helper.h    |   2 +
>  rust/helpers.c                     |  45 ++++
>  rust/kernel/block.rs               |   5 +
>  rust/kernel/block/mq.rs            | 131 +++++++++++
>  rust/kernel/block/mq/gen_disk.rs   | 174 +++++++++++++++
>  rust/kernel/block/mq/operations.rs | 346 +++++++++++++++++++++++++++++
>  rust/kernel/block/mq/raw_writer.rs |  60 +++++
>  rust/kernel/block/mq/request.rs    | 182 +++++++++++++++
>  rust/kernel/block/mq/tag_set.rs    | 117 ++++++++++
>  rust/kernel/error.rs               |   5 +
>  rust/kernel/lib.rs                 |   1 +
>  13 files changed, 1071 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/block.rs
>  create mode 100644 rust/kernel/block/mq.rs
>  create mode 100644 rust/kernel/block/mq/gen_disk.rs
>  create mode 100644 rust/kernel/block/mq/operations.rs
>  create mode 100644 rust/kernel/block/mq/raw_writer.rs
>  create mode 100644 rust/kernel/block/mq/request.rs
>  create mode 100644 rust/kernel/block/mq/tag_set.rs
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2dc01551e27c..a531f664bee7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -702,7 +702,7 @@ static void blk_mq_finish_request(struct request *rq)
>  	}
>  }
>  
> -static void __blk_mq_free_request(struct request *rq)
> +void __blk_mq_free_request(struct request *rq)
>  {
>  	struct request_queue *q = rq->q;
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
> @@ -722,6 +722,7 @@ static void __blk_mq_free_request(struct request *rq)
>  	blk_mq_sched_restart(hctx);
>  	blk_queue_exit(q);
>  }
> +EXPORT_SYMBOL_GPL(__blk_mq_free_request);
>  

Note that for an EXPORT_SYMBOL_GPL() symbol, you can just add the
corresponding header file in rust/bindings/bindings_helper.h:

+#include <linux/blk-mq.h>

and you will be able to call it from Rust via:

	bindings::__blk_mq_free_request()

in other words, rust_helper_blk_mq_free_request_internal() is probably
not necessary.

Regards,
Boqun

>  void blk_mq_free_request(struct request *rq)
>  {
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 7a8150a5f051..842bb88e6e78 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
>  		unsigned int set_flags);
>  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
>  
> +void __blk_mq_free_request(struct request *rq);
>  void blk_mq_free_request(struct request *rq);
>  int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>  		unsigned int poll_flags);
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index f8e54d398c19..df18acb229d9 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,8 @@
>   */
>  
>  #include <kunit/test.h>
> +#include <linux/blk_types.h>
> +#include <linux/blk-mq.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/mdio.h>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 66411845536e..017fa90366e6 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -21,6 +21,9 @@
>   */
>  
[...]
> +
> +void rust_helper_blk_mq_free_request_internal(struct request *req)
> +{
> +	__blk_mq_free_request(req);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_blk_mq_free_request_internal);
> +
[...]

