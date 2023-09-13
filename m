Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3E79F547
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjIMXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjIMXBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:01:50 -0400
Received: from out-227.mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF2A1BCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:01:45 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694646103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=936FjOrJ5smwNM8opXoifLeImI0aNI7wDdh2+lfJJno=;
        b=p9xXQT3eeIpGBB2+SQb2w8E1bHynlFI1LXkI/rh0VGAUzF8IDHgPqGkIhXXvXn+X89XW/8
        l7+BUnexQZDrQuED0EmL/4NW8BFVuXGYYHw+0jRN8iWk4RqfuJ+GxvlrVlduHyJMpj5wWg
        7lNT1oYTpnqhGXu56vNEc9rgWhn8diM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: Fix a potential in the error handling path
 of use-after-free inbch2_dev_add()
Message-ID: <20230913230135.y27i2bx244tdjhvj@moria.home.lan>
References: <3ab17a294fd2b5fcb180d44955b0d76a28af11cb.1694623395.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab17a294fd2b5fcb180d44955b0d76a28af11cb.1694623395.git.christophe.jaillet@wanadoo.fr>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:44:08PM +0200, Christophe JAILLET wrote:
> If __bch2_dev_attach_bdev() fails, bch2_dev_free() is called twice.
> Once here and another time in the error handling path.
> 
> This leads to several use-after-free.
> 
> Remove the redundant call and only rely on the error handling path.

Thanks, both applied
