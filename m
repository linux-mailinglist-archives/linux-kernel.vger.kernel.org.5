Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5C7C596A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346943AbjJKQno convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjJKQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:43:42 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29201E4;
        Wed, 11 Oct 2023 09:43:40 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qqcJ8-0004S7-2t;
        Wed, 11 Oct 2023 12:43:38 -0400
Message-ID: <6347cb90238ce61fb21a8203da53497663cee60a.camel@surriel.com>
Subject: Re: [PATCH v2] execve.2: execve also returns E2BIG if a string is
 too long
From:   Rik van Riel <riel@surriel.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     linux-man@vger.kernel.org, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Matthew House <mattlloydhouse@gmail.com>
Date:   Wed, 11 Oct 2023 12:43:38 -0400
In-Reply-To: <ZSbD59Y5y3zNGC1h@debian>
References: <20231011101134.709b8089@imladris.surriel.com>
         <ZSbD59Y5y3zNGC1h@debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-11 at 17:48 +0200, Alejandro Colomar wrote:
> Hi Rik,
> 
> On Wed, Oct 11, 2023 at 10:11:34AM -0400, Rik van Riel wrote:
> > The execve syscall returns -E2BIG in 3 cases:
> > - The total length of the command line arguments and environment is
> > too large.
> > - An argument or environment string is longer than MAX_ARG_STRLEN.
> 
> Please mention that this includes the terminating NUL, as Matthew
> confirmed.  Otherwise, to user-space programmers, this would usually
> be
> interpreted as `strlen(p) > MAX_ARG_STRLEN`.
> 
> An example program that demonstrates the limit would be very
> interesting
> here.

Thank you for the detailed review.

I think all the comments are addressed in version 3.
-- 
All Rights Reversed.
