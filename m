Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD677EAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbjHPUjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346191AbjHPUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:39:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722342701
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:38:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbf10333bso44694175ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692218339; x=1692823139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mebqjsm4NZp8ScdZvCRAS9NYd++02rPC44UvNuMOWag=;
        b=B+9GwZKIjimcZET39jiEv3WT0GoLENkoUfDXOud4xZGq1bLQ1uxHedO/2+FXbu7uVA
         Y9WlkpPr4WpBzxpKyuS8Pvf+B1kG+L9oA4H2PNzOk4n1hZl3E0VlEt2/uWNI9vGw0Lv1
         Uug01LJbx6MbgyC/oVAaHSUyikQJHyIlZe/Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218339; x=1692823139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mebqjsm4NZp8ScdZvCRAS9NYd++02rPC44UvNuMOWag=;
        b=ODkZTZEgGNXK6IdspERd0ng6myJEy/zW1ec8QzGSxhr5+vVskjLZ0N6nUIGxCaK18W
         WTcB6hCLKg68n0PdvMtHVIOPlEuqdq5spT6ZBkVt3p1FtH56ShjJzqNXK8dSLsPzwe/D
         +EIYGQpgdNjdAbNxsqkhw73XKFw9NkCpMxoGRBScrZ/PURPQqG84Wd6erkcos48q6Iyg
         dND+GAo3V6Kw0TBN0gZQFH1O9KtQ7o18QhrWinX4mc5ueIRn3MEheFSZnD7eIWyTsPDr
         h4tOplYfZL9yCURdRGS9UhuwosvUepgvBFpVb/8cqzXqMV4l0GI/l8R8WHKMtM6By3J6
         kMsg==
X-Gm-Message-State: AOJu0YwQ0Uk+m7EfOGGbEWP+iyi5HFAI7YTmNh0/iSBWruvhuBLge0k6
        nGNIu6UoP1pyRueMPAGjsn5swg==
X-Google-Smtp-Source: AGHT+IH8TNVv8K24tYufYWfhj6FReA3GRy3bUNjldrAPON0uLm7g+SZDkIHCoYjL1zNAe1G0wAMRyA==
X-Received: by 2002:a17:902:c94e:b0:1bb:598a:14e5 with SMTP id i14-20020a170902c94e00b001bb598a14e5mr2728850pla.43.1692218338963;
        Wed, 16 Aug 2023 13:38:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001b7fd27144dsm13607893plg.40.2023.08.16.13.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:38:58 -0700 (PDT)
Date:   Wed, 16 Aug 2023 13:38:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] nouveau/svm: Split assignment from if
 conditional
Message-ID: <202308161338.C7162E7@keescook>
References: <cover.1692208802.git.gustavoars@kernel.org>
 <6b900e80b5587187c68efc788f5b042ca747d374.1692208802.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b900e80b5587187c68efc788f5b042ca747d374.1692208802.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:05:06PM -0600, Gustavo A. R. Silva wrote:
> Fix checkpatch.pl ERROR: do not use assignment in if condition.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
