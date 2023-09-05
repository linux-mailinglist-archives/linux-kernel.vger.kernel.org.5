Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366A9792684
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbjIEQJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbjIEL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:28:52 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C907C1AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:28:48 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401f503b529so23685165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693913327; x=1694518127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBDYPrNVNQs8uedEw8LKqB5eVyDGiSNo3aWK9hkZDss=;
        b=uxAD+SQVZhdtrEN7fvCyH0gB9gZezEu15ZkfIhIeWICaYScCQnm2uvLSPfD2PyXj9N
         2hBY7FgMAz76XDeBeAJbABYg+6DYQIdY2cG4m8y/2+rM9VX09UVFiJn7nwB8nto4o/D8
         0Lzyz7gAWSOJk1CCJNoChnuhHYzq1cq1f4MdUt4cwn9ZNVuGNP8JHNp+3ImrBGf7y4Go
         khehxSeNQzeyhwyi899//NOtfchxxn5H+Mkv26U+ghaA4RFKRaWHBSMYyCaYOGnFf6WO
         NC0WZ8dhlyJdVZsGDpodqKUfM77iFrhJ+3xhzhLhcIMp4nctveOC+qrDxlkdBLxFWP/F
         oR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693913327; x=1694518127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBDYPrNVNQs8uedEw8LKqB5eVyDGiSNo3aWK9hkZDss=;
        b=IRj6P1OlmFnPHzthtb+Z8DcFtqi/NwUupUdbK6KVnsFLHuVKn3rSkzAFGXv+58+A7O
         WOHZJTUPy3oAFjYJn+6z5J+elNbc3iu6rQvmAymlEJ+1HGk7Tm8G0rerdbuVXKkwi7Z2
         J5Rew8UqCmMonMptnOVeo9nxUrXz1VwRuBheopUiLeQjJ3nBpgjrs0j7nCw1e/eXm97q
         0SnDdwfiU/akNyUf5NIvEDD+MHaS9pNZyhAi2dWJnqwbHB437AXVHcqYMftdTfZ3up2Y
         Vw2iq8p0oNHQXvf5w18+nylv1GarEv6GAOVBlE2JUqaDXZ5DrOlhmbFU1qe3kaA+H1Dk
         LDnw==
X-Gm-Message-State: AOJu0YyqRd7hnEzRZkRuerI2oDkxwVrh5GfzBAsU5SLNF1bpb7U3wfKK
        DgXMu1qUbAduj4uh2NQv7JjtPEUOljMVRbK4W7Y=
X-Google-Smtp-Source: AGHT+IGDVf33SsIv4JjPVvlDTBDhZwEBkV1Kn8Ud5kUo8iMjmsdpaIcy8Ty86NaRmLG7gKJTd1v7gg==
X-Received: by 2002:a7b:c8d5:0:b0:3fe:3004:1ffd with SMTP id f21-20020a7bc8d5000000b003fe30041ffdmr10106023wml.4.1693913327216;
        Tue, 05 Sep 2023 04:28:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0031435731dfasm17137871wrp.35.2023.09.05.04.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:28:46 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:28:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: Fix block comments where '*' on each
 line should be aligned
Message-ID: <8ab11a98-5631-4ff2-93d7-dd0a7d72dd6a@kadam.mountain>
References: <20230903203732.585378-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903203732.585378-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 10:37:32PM +0200, Jonathan Bergh wrote:
> Fixed checkpatch warnings where lines with '*' in block comments should
> be aligned and were not as well as incorrect tab spacings at the start of
> comment lines. Also removed spurious newlines between define statements
> in define blocks

Do this in two patches.

patch 1: delete blank lines
patch 2: change comments

regards,
dan carpenter

