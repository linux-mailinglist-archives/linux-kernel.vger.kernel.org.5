Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917107A675C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjISOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjISOzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:55:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D545DF;
        Tue, 19 Sep 2023 07:55:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDACC433C7;
        Tue, 19 Sep 2023 14:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695135339;
        bh=PHhE/Lt3Hz7iR4g9GdYD+OxDJ309R2RTFntqEuHpPoQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I7yain0l/vUioWrBwIjH0N5q+w1z2y2RW62AuBQd8J6SrQlVw+2vrhpAEEmKB36hu
         Oro0oXkl+Ahnuz1F8DmXUUMqQjnX2S81eS6WD5VXNsbRhcMia3ViwjX9fN6FRL6Wsf
         s791Y+AuMLLJSsQL3siONHetA7uz/qF4o0HmgWaEsxOtUw0Kh8I5FqK0enDagk+3R3
         l+z7SHRpkyxgrw6OLRH4uIRhJdeQDSf3QLFlzImNBnEkG8RxahUxt41b8PNN96S3mR
         QTbGR7j2aD6YU+6UaroIWuuSeV4amQW8d4dusBc0Oi+7yQcRzTKoviHi0cytli1CaV
         B1p+32db/zhaw==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20230816-void-drivers-leds-leds-pca955x-v1-1-2967e4c1bdcc@google.com>
References: <20230816-void-drivers-leds-leds-pca955x-v1-1-2967e4c1bdcc@google.com>
Subject: Re: (subset) [PATCH] leds: pca955x: fix
 -Wvoid-pointer-to-enum-cast warning
Message-Id: <169513533778.3252260.12959111862312719443.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 15:55:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 19:37:52 +0000, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |      drivers/leds/leds-pca955x.c:487:15: warning: cast to smaller integer
> |      type 'enum pca955x_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |        487 |                 chip_type = (enum pca955x_type)md;
> 
> This is due to the fact that `md` is a void* while `enum pca995x_type` has the
> size of an int.
> 
> [...]

Applied, thanks!

[1/1] leds: pca955x: fix -Wvoid-pointer-to-enum-cast warning
      commit: 0e2e05099162c089a9b4dac563ae71b4c01a5f8b

--
Lee Jones [李琼斯]

