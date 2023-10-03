Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB627B6D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjJCP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjJCP54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:57:56 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6277FBB;
        Tue,  3 Oct 2023 08:57:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0C9E7381;
        Tue,  3 Oct 2023 15:57:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0C9E7381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696348673; bh=kjVGjclWPNILX2rkBbU6fsiYS307e6ZdrXjXRApQkXM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BGPdd/0GVHip9lzD3SAt8VCsPiLiSNOFLeugMe9MUBJUSYVcoVBz0JBbxeXMDxvu/
         7hj0JGG/cs7VJyDJQv9hPIDitGZXc33Eak0/ZGx6s3eIlYifnwAfQA6kRZns965NHg
         TZ3HIEZLPEBE3iI8dxMQAR41bT7CPx0XA/OyKUyeahJ3chhNY0BWJhzv0GkqenO+Tu
         2ZL4R17yiaABIn9EBgKNG2l4D7geaWgDkdKvkU8iOesMkyupHz+lbPwb4Vs0bWPGgO
         U1S9VCRoYoqZB43GP6yT7YsqTyRzQlPBu+Iv0DduqfRiaq5eHcAc8uNrql6Zn4bZXZ
         0OBfDVbIZZ+Zw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Oliver Faso <erer1243@gmail.com>
Cc:     Oliver Faso <erer1243@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/sphinx: Explicitly convert Sphinx paths to str
In-Reply-To: <20230910040811.53046-1-erer1243@gmail.com>
References: <20230910040811.53046-1-erer1243@gmail.com>
Date:   Tue, 03 Oct 2023 09:57:52 -0600
Message-ID: <87pm1vem0v.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Faso <erer1243@gmail.com> writes:

> Sphinx 7.2+ is switching to using pathlib.Path
> instead of str to represent paths. This fixes the
> current deprecation warnings and eventual breakage.
> This conversion will be a no-op when using older
> Sphinx versions.
>
> Signed-off-by: Oliver Faso <erer1243@gmail.com>
> ---
>  Documentation/sphinx/kerneldoc.py | 2 +-
>  Documentation/sphinx/kfigure.py   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I've applied this, thanks.

jon
