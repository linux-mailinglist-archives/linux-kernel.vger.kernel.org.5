Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D977CFFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjJSQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjJSQue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:50:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B013A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:50:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B14CC433C7;
        Thu, 19 Oct 2023 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697734231;
        bh=FXh21OoAGR8XHVEBB81BE7UVszOS/EKxof6T4KL6Nl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BnG+Idv8nNr0gcKnCyQpK3n/ViH2zsIUK+GNsyvYWvaNLLRkuhA3s6xv1G6OP5uEJ
         z8+9ayy43IEQoWYNVfjdT9j5RzedEbnOiqaC9LsPyfeKYpLo32AhxWtG1lYZdAId81
         oVxmwWcFznV37Idq+XTw28lf/Vy534RnOGktF4do=
Date:   Thu, 19 Oct 2023 09:50:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Philip Li <philip.li@intel.com>, oe-kbuild@lists.linux.dev,
        Lorenzo Stoakes <lstoakes@gmail.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed
 'vm' could be null (see line 3667)
Message-Id: <20231019095030.7a1f3c93bc18511f52524aa8@linux-foundation.org>
In-Reply-To: <ZTCURc8ZQE+KrTvS@MiWiFi-R3L-srv>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
        <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
        <89caf59a-d3b9-409d-b1ae-9e370cb9ee7d@kadam.mountain>
        <ZS/LrhcxcMOgiiX5@MiWiFi-R3L-srv>
        <ZS/TVMT9ed7OdyNy@rli9-mobl>
        <ZS/2k6DIMd0tZRgK@MiWiFi-R3L-srv>
        <20231018085248.6f3f36101cbdfe0990c8b467@linux-foundation.org>
        <ZTCURc8ZQE+KrTvS@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 10:28:21 +0800 Baoquan He <bhe@redhat.com> wrote:

> I think this is not a real runtime bug. The only chance it can hapen is
> when (flags == VMAP_BLOCK) is true. That has been warned and could never
> happen. I updated patch log and paste v2 here. 

Thanks, I updated the changelog in-place.
