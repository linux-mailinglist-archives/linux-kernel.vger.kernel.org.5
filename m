Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC97C6F95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347198AbjJLNqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343854AbjJLNqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:46:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DDBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:46:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso1245933a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697118370; x=1697723170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WL4o0PnlTALPx2JWXQcQVAR5wsdcklh2Oh9j6J5p78o=;
        b=s8s5pySfVGsOvbqrWvK2k8LuNwRuOVSZz33KIMLX/3ba1xPeA2UmJWZqChehN3e92F
         v04YzDGP7HVwEwYO5OWlA8ULMTru471sNQIbYNZww5xDJ311BvdxnWp1JFavlr9QOQLf
         wC/w7VNQabGsjUdburO0JP/G+GUbeKJJ4uZQrjlnFo0qJh0PJ21z3ZX7+2VlF9Hn7OZL
         Gvz3aGCRnONbfH7npfPypuDvMH4DqykZB0E0Rpx/XH88v8KC+ORzMTLPDWnvINrQxqAb
         v3k/b6+ljnzNqPNLgl5zsOELAweH2VCP9Q+e6yIAbQ/thAECha6Ai1PRSJJPeNa1EG1d
         bx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118370; x=1697723170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL4o0PnlTALPx2JWXQcQVAR5wsdcklh2Oh9j6J5p78o=;
        b=e4rTKm/vClZT0vxaOGAPvY1lYVPJbzwaX2EehIAZZvk7cT8fR4isRQ6G4Fn+/bQkdd
         3+I4d7ku6XezNC/SS3d5Pfy2U83DGpirb9pvm4v5RrF15/LRKdknuC8JhMh560e7FCUi
         DHzGhv7MUvNNeqSQOlQHgF61bM5NVeAoEXPUf9qWMJ8uFS4ybVq47K0GBzar1lZd2lo2
         7V/JTYruzX77VPp2+LIyVs5cQzv2gDsjpRxG7wD640D5YT+wCkZIq1sGvulftz+xTnNN
         Ieffnb91i6OSonS+un34ux97LSJe/dxXRHRpM4Kn/TkoaiyHwYfIh86bYxO73fpS0zE5
         DKuA==
X-Gm-Message-State: AOJu0Yxd7lOgLxqXpVJydFMrKwyANwLUWWrKF6lfduNtpByJ+fDCV2TF
        +DRNHduGxRVt+3NZj0ED7pBxlg==
X-Google-Smtp-Source: AGHT+IH59hmoDS+3N9HnCWrAqCjVPZ4ryC0EzwYrla5+l9OzTXH6ATWKCWWbfSW9us9NhxA/rflDvg==
X-Received: by 2002:aa7:d14c:0:b0:533:2327:1eed with SMTP id r12-20020aa7d14c000000b0053323271eedmr23591165edo.24.1697118370561;
        Thu, 12 Oct 2023 06:46:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id er24-20020a056402449800b0052febc781bfsm2998183edb.36.2023.10.12.06.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:46:09 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:46:08 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wpan@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
Message-ID: <ZSf4oCBXZGi2BfqC@nanopsycho>
References: <20231011140225.253106-1-arnd@kernel.org>
 <ZSa5bIcISlvW3zo5@nanopsycho>
 <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82527b7f-4509-4a59-a9cf-2df47e6e1a7c@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 11, 2023 at 05:57:38PM CEST, arnd@arndb.de wrote:
>On Wed, Oct 11, 2023, at 17:04, Jiri Pirko wrote:
>> Could you provide a cover letter for the set please?
>
>Subject: [PATCH v2 00/10] remove final .ndo_do_ioctl references
>
>The .ndo_do_ioctl() netdev operation used to be how one communicates
>with a network driver from userspace, but since my previous cleanup [1],
>it is purely internal to the kernel.
>
>Removing the cops appletalk/localtalk driver made me revisit the
>missing pieces from that older series, removing all the unused
>implementations in wireless drivers as well as the two kernel-internal
>callers in the ieee802154 and appletalk stacks.
>
>One ethernet driver was already merged in the meantime that should
>have used .ndo_eth_ioctl instead of .ndo_do_ioctl, so fix that as well.
>With the complete removal, any future drivers making this mistake
>cause build failures that are easier to spot.

Looks fine.


>
>[1] https://lore.kernel.org/netdev/20201106221743.3271965-1-arnd@kernel.org/
>
>----
>Hope that helps, I had commented on the cops removal about sending
>this but of course not everyone here saw that. Let me know if I should
>resend the patches together with the cover letter.

Yes please. Thanks!


>
>    Arnd
