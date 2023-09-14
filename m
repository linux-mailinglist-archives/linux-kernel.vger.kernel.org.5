Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1FB79F638
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjINBRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjINBRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:17:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578FB1724
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:17:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-577a98f78b2so287492a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 18:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694654222; x=1695259022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihw/w0W7BDzixR3ewilohKIIF2rbRpPJPFFD7K5PVUk=;
        b=cpWTcBh4qm06X80OIfLEwXzD7zlkdnsafUj7AGJOBQ1s1pZwZhmS6JbXhZXoe+eDrp
         Iju/X++hUp/yCGIiHCJ85Rtc2mwMnXN8zxUR39VwQbf5Gzg8AlGYXJafsYSDZqSbx7Sn
         rjISjt0bBfqROGKBWljQ4jTGy8cnzcSfM4BpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694654222; x=1695259022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihw/w0W7BDzixR3ewilohKIIF2rbRpPJPFFD7K5PVUk=;
        b=cNCEqbT65KaryMECMt6WBBGb0ovjc3Z3sZDGNUE87ND5NGdRUcsCIiliNJfewDG4O9
         DOOALSNZuW1yGKgMYog++pMnHsI8jraB7Ae0AxqssAnZfpltl1h3MShO321tzJHrzSVA
         wGTbydIUahjIKJx4YwtXISGanDQiiioIc4oOy8F+kncgcfraXwyuErHKT3KWhNuTSQVm
         g5iYA1MdqlmZdeOWUy9KvEK3ebC7paO9BMG5KKowjbkVclxeTTUWE51oSGLj9R5ZSOTY
         1Zfo39tJ+dxjcQSQO/F/jPCZotUjuB912npkin+yUvpY1aBXJ4RcVHnoMZeiTukOP3eP
         Ocvg==
X-Gm-Message-State: AOJu0YwFjZiK2rXSBIO9AZX+1JAdyhtQuIkrTDKD9+0pU4xMWjJOjpQF
        VrvsPSr3vXATNHW1wznygKtbPg==
X-Google-Smtp-Source: AGHT+IFVmYS1mEYcMd/p0TYkZElmVKZ0TvdZYoGAZ8deMfNttmytOKJceq7xikmtSEIS5kZK8NfgqA==
X-Received: by 2002:a05:6a20:e122:b0:14c:6a05:dfbf with SMTP id kr34-20020a056a20e12200b0014c6a05dfbfmr5188625pzb.60.1694654221813;
        Wed, 13 Sep 2023 18:17:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001b9e9edbf43sm238226plj.171.2023.09.13.18.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 18:17:01 -0700 (PDT)
Date:   Wed, 13 Sep 2023 18:17:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: linux-next: Tree for Sep 12 (bcachefs)
Message-ID: <202309131803.6A3C1D05A@keescook>
References: <20230912152645.0868a96a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912152645.0868a96a@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:26:45PM +1000, Stephen Rothwell wrote:
> New tree: bcachefs

Thanks for going through and fixing all the fake flexible array members.
It looks much nicer. :)

I have some questions about the remaining "markers", for example:

$ git grep -A8 '\bkey_start\b' -- fs/bcachefs
fs/bcachefs/bcachefs_format.h:  __u8            key_start[0];
...
fs/bcachefs/bcachefs_format.h-  __u8            pad[sizeof(struct bkey) - 3];
--
fs/bcachefs/bkey.c:     u8 *l = k->key_start;

Why isn't this just:

			u8 *l = k->pad

and you can drop the marker?

And some seem entirely unused, like all of "struct bch_reflink_v".

And some are going to fail at runtime, since they're still zero-sized
and being used as an actual array:

struct bch_sb_field_journal_seq_blacklist {
        struct bch_sb_field     field;

        struct journal_seq_blacklist_entry start[0];
        __u64                   _data[];
};
...
                memmove(&bl->start[i],
                        &bl->start[i + 1],
                        sizeof(bl->start[0]) * (nr - i));

It looks like you just want a type union for the flexible array.
This can be done like this:

struct bch_sb_field_journal_seq_blacklist {
        struct bch_sb_field     field;

	union {
		DECLARE_FLEX_ARRAY(struct journal_seq_blacklist_entry, start);
		DECLARE_FLEX_ARRAY(__u64, _data);
	};
};

Hopefully that helps!

-Kees

-- 
Kees Cook
