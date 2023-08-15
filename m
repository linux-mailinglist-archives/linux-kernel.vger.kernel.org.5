Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2025977C45B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjHOAQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjHOAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:16:14 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2605FE51
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:16:13 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a76d882052so3939200b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692058572; x=1692663372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6MdxNN/aJD30cglPkMaxjkUwKONXF5sIB55iOEaefE=;
        b=GznAYayaFAi0hDwaGIyeywKrf2hs+hF3f0c5Sh75j8hw+BNX0hriLNZQKL32UOVSp8
         HmIQKkT9iZjsJ8dxbxXKE665pMrdljw3UjgHc/z/dVQDwfAX2FzMymVlu0mZxVUFGwgR
         91ufxvsrm3QJhT1YGCv3/WFC33RouhD6vVs0yKWk5ES7PqcVotK4IijLO+WVOrzFh80H
         I6nUovlKrnkv3W9xjLjTiRZhYKrgzeyNdlJYI7o4H/rTw3/dzlEEamEgvk8lvKSTOcin
         Aw0BAk/FBLxK4K99Wm3+OUSqu/5BUory1ZMxg2UMrX3u7jxAyvw25TOoJhR60rfJfhY+
         TXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058572; x=1692663372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6MdxNN/aJD30cglPkMaxjkUwKONXF5sIB55iOEaefE=;
        b=RKbbU6m+qMG7flbEnyOhYVD6SjUXt3+jO2RVr3TjfzV/k/KiA/FORlZ/S4fN1vckQn
         rMkq+VMDkCKYAI2LtFyQ+vyt7GPsijQetWgX/iUlc9U2m63R0smKfBZC94WAYZXYyKaV
         BVqVLdQarSYzH9DugQoxyYTJsMRPtQRhDHPbkuPJc1y4REItOTst1P1fsZj9QZ9yu1s6
         0J16kW3+SZkUyiwZBK+1x1FWk2VnPeF2pusSMow0EjHiHUl39iBdsXZnimDNXcnCKcxL
         /kXlylmYNGFBJlU/AVpwrau1yE/XOONldM+1p/e/E/hG8Q6yALVQraS6OwAvHBzfrUI0
         1FWQ==
X-Gm-Message-State: AOJu0YwFai9PSQj3JFpap76bfGv2PS4h6w6CJpmrkm4tozpH3NxZaO7g
        sILQZlTYIzIzNcP5EQGQadzEQha+kpU=
X-Google-Smtp-Source: AGHT+IE6Nw/P6OUWwuW3ciTOwjp9lz75p5z/I2CSs2lW6r8hZ057eMvqn5Kd23AGorxtfCGTJvxzNw==
X-Received: by 2002:a05:6808:492:b0:3a7:5d83:14d2 with SMTP id z18-20020a056808049200b003a75d8314d2mr5179384oid.17.1692058572392;
        Mon, 14 Aug 2023 17:16:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id o4-20020a63a804000000b005651c9351e1sm9143538pgf.64.2023.08.14.17.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:16:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Aug 2023 14:16:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     shr@devkernel.io, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com
Subject: Re: [PATCH -next] writeback: remove unused delaration of
 bdi_async_bio_wq
Message-ID: <ZNrDyr1BEGGFh8Id@slm.duckdns.org>
References: <20230812110128.482650-1-xiujianfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812110128.482650-1-xiujianfeng@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:01:28AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> It seems it was introduced by commit d3f77dfdc718 ("blkcg: implement
> REQ_CGROUP_PUNT") unintentionally, but the definition does not exist,
> remove it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
