Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFBD805749
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbjLEO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjLEO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:26:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54C290;
        Tue,  5 Dec 2023 06:26:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b5155e154so61390465e9.3;
        Tue, 05 Dec 2023 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701786385; x=1702391185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Op8EMMLSn4u+aBPhlPBNq3QMTgHXM3GBpRsFBgi0BfQ=;
        b=Je+fNcYYEL+oFZXHBG4vyEm4q3MDARjCNpqHxjZnjM73qqZMRPVD7xWZibgPTy3/qZ
         cZ8IXlBB5x0tjJMdxDVWKk3z3BjzFi3X1paWRN+UEdh+T3DddyG+cimxxBfEEFaBW6E/
         ksHVOnfKLbiMXQk9AGNjof23UTBc9YcjXzmsaZH5pbEVa6P+wzBYPzH5cu7dKdJtrQMh
         uKQ/r54G+UJpU6cqaRA3UmR9U7XTCcCTE2WMnHPL8Epk49F602I7KbEMwBGF1/hvwnNo
         dOXjcZoiWBK9RZeYs5Fi76sJn4nFe7doVl6pARNwGz4QT1cIckkCePFkTQLeXxmbSHUG
         gxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786385; x=1702391185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op8EMMLSn4u+aBPhlPBNq3QMTgHXM3GBpRsFBgi0BfQ=;
        b=dzH6VgYL2LMwnS30vzjJhaVXTq31R7cx0QQDTbh92Wrco9v9OBnX8Lc8ST1acPKaPU
         VZL56HFq97M/uWJv4ERUImKDOo6fdDRLu7zpBgqyaIdexAav3qJZKTAMLGQ9uoQki/cQ
         NBQgparuqcNzUelqonsVzhTJ14wXb4vW8/nCt1jH0RaX9TuVEXKOnwxkvWCyGaIBlI8G
         nwazp/4BLRmfxQePJgk1/I0Si5Rn6tCw1uHu+DLwT5m4wGOgACiGJ/nVLbei6YyBU80t
         ezpCKatvYywYsIjnqgc74uQmGhwPUaoLT6/2yegvHwvIMYiegkfCj+DcvOs7zlByIMoy
         2t+Q==
X-Gm-Message-State: AOJu0YwzAzKu92baV5gGxaknFvOj9FhAHzuvVJJIljX+N/DtMD+DePBx
        judPtpq3C2Tfz64Ke2OgfGhN0bjE6Q==
X-Google-Smtp-Source: AGHT+IHHROYIemcb/wsY8oPQMU7gMIn1gsTtBT9VDn93wCGrv8ctub0VOQUxcGsJwZ8m28SEOnej3w==
X-Received: by 2002:a05:600c:4f50:b0:40b:5e1f:6fd9 with SMTP id m16-20020a05600c4f5000b0040b5e1f6fd9mr501528wmq.46.1701786384964;
        Tue, 05 Dec 2023 06:26:24 -0800 (PST)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c451400b004094e565e71sm19022491wmo.23.2023.12.05.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:26:24 -0800 (PST)
Date:   Tue, 5 Dec 2023 17:26:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_LIST)
Message-ID: <75344429-1f34-4a14-ab10-8613846d694e@p183>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v89dvuxg.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:51:39AM +0100, Florian Weimer wrote:
> * Alexey Dobriyan:
> 
> > +/*
> > + * Page sizes available for mmap(2) encoded as 1 page shift per byte in
> > + * increasing order.
> > + *
> > + * Thus 32-bit systems get 4 shifts, 64-bit systems get 8 shifts tops.
> 
> Couldn't you use the bits in a long instead, to indicate which shifts
> are present?  That's always going to be enough.

Yes!

I was so proud of myself for this line:

	val |= 21 << (s += 8);

Now it is boring bitmask again :-)
