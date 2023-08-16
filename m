Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C342E77D8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241426AbjHPC7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbjHPC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:58:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4158268F;
        Tue, 15 Aug 2023 19:58:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbbede5d4so39334045ad.2;
        Tue, 15 Aug 2023 19:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692154725; x=1692759525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2WdeGXX+ZF+x3868G2g3Cg+j+fq+4mIp+LIBbQQhbrM=;
        b=RAgbZFpx0Vslt2E0eMr8rdl6lNigUNQ5zzuWgVRLv8hzHD/GtGc/y2+aK/E7WlrpLh
         cwOfCGXO68A7U+nqu94fH65aCJ9wCJACMRTye+tex3NrCMLppfw7blUZKV1LlIHIyaLs
         CbrrNCPlhfquidZYku8TWQs715S6zlpjPNoR280z3gpESSHeopPSE6EIeGfiV1sgqPnh
         b7UVMXZXrJuzdz08GoM1c87Cqe7M3Et40G+1GDBWXKx2CjKpxYwkRcJjg8zLQQGqdySZ
         U5qLWIuKYFJB3ProwgkS3vqR4ftuPtxISQ6w9pNfk7StVuauKIldmgt8TkX145v8OWOL
         HB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154725; x=1692759525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WdeGXX+ZF+x3868G2g3Cg+j+fq+4mIp+LIBbQQhbrM=;
        b=DOcvAfMypxHGXwEI8p76O2uVtntBq1WXkM7vsUuRkYCmQsBB6PAEK8jgZ+Qqd0q06W
         EL74gMnWpfv8jTOy/MkiXN1eVUxWfP6mU3MdaxVRYhndLO9OFFgFI9RtZmdGIxoZ+n+P
         Atw4yMa/I11msI6GNklg3E4uGgMZN3Z1VwCTSbrvpXX+p0btm6zrZJOHvdlYYcJAoPI6
         3i6zaGgEJS6I8nHn8Pskb71dOMKEdRgQv+2ID3L7CdTNiKU1MU5Ku6At99zGGE7VBoSd
         Xgw8tQo0AaMBuyO9ZlagmRzoA2dIv/MSzPuUfL6I8X1pvdi0sncwhRvr7HCc4CMxqq81
         w8Cw==
X-Gm-Message-State: AOJu0Yy/GM0yk1ysM4zBA2m8uzbCFx0Ex/8NICZv2KwfY3xV/MmBWstW
        5Xj1pnIf1O4XvL1m0muUxxTIFC+WxrE=
X-Google-Smtp-Source: AGHT+IFEq4s+iFA8LoTUnd1YvFyxR6w0WXzOR84soBndyUjJIs8LY/IveMGtE/0ijqtWnWmIy5bkXw==
X-Received: by 2002:a17:902:d507:b0:1b8:971c:b7b7 with SMTP id b7-20020a170902d50700b001b8971cb7b7mr784657plg.56.1692154725136;
        Tue, 15 Aug 2023 19:58:45 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:6a8f:3187:b8c8:1572])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bda42a216bsm11465256plk.100.2023.08.15.19.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:58:44 -0700 (PDT)
Date:   Wed, 16 Aug 2023 08:28:39 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: auditsc: Removes use of assignment in if
 condition and moves open brace following function definitions to the next
 line.
Message-ID: <20230816025839.GE57274@atom0118>
References: <20230815204644.52358-1-atulpant.linux@gmail.com>
 <20b96495d277cb2007541a119bb09def.paul@paul-moore.com>
 <CAHC9VhSQ9FsxF2rg57B-V5f23OKAA-uCHb1iOkCiTuNeTXHMbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSQ9FsxF2rg57B-V5f23OKAA-uCHb1iOkCiTuNeTXHMbg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:14:25PM -0400, Paul Moore wrote:
> On Tue, Aug 15, 2023 at 6:10 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> > >
> > > The patch fixes following checkpatch.pl issue:
> > > ERROR: open brace '{' following function definitions go on the next line
> > > ERROR: do not use assignment in if condition
> > >
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  kernel/auditsc.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > Merged into audit/next, thanks.
> 
> I also wanted to say that I changed the subject line to "audit:
> cleanup function braces and assignment-in-if-condition", what you had
> written was far too long for a subject line.  A subject line should be
> brief and does not need to be a full sentence, in fact it probably
> should *not* be a full sentence.
> 
	Thank you for the comments. I agree with your point on subject line
	and will follow your advice in my next patches.

> -- 
> paul-moore.com
