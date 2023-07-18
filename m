Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5A758813
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGRWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjGRWBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:53 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F61FF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403ee42444dso19306061cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717689; x=1692309689;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbnlGsxyxSPT53z8AvSahZZVuaqRwE/5/RY1mx0XV3U=;
        b=dxfo7k0ShfODOvc1LMGi2GhhOlc40dkJm/0iSfwwzsqI2crweOjOlZm0BdcwX63ncO
         Vo+oRwQQAUcIuf2X+J6WuvULXlVlmfY2/pdV7DkVj4wS2i+g+VigiI3WAF+jmdzQCysa
         kUpvQFbMHkJ9O5tHLscyTDw3+vyggnbCqcUMMtWlCviReklTU3h0zx6FIK8OhHaRVRxU
         dvq3D/6TkWGtHjdvJxUPPGHwBXuW74K5cNM0GKYM+PRfjfm3UBpfc8FSJG6MiZJ0DdDZ
         01YtWeystBAY+zKtzpa9iCW8yBPfDFHtEw6Sz3vLobGGfEDRWVuyKW+cHwPL60U7EmZm
         zduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717689; x=1692309689;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbnlGsxyxSPT53z8AvSahZZVuaqRwE/5/RY1mx0XV3U=;
        b=fTEEhCbEJeyth5jM9JG02i/F++nJfl9fWyHYZz7QvhtHAhS8cyFL3Brrg77O6snuIV
         lpb1lWjniOXXZlwcjbIa6rHlAnqkJ6vj23HTTJGwW8L8TXCBHqGT/UKLfHKuzb5lJ4QD
         Q5Yz3rG0EOIaw0Po6lo7PEy3Qj07OuRjXbe5rtR05k3HZj039U0zcyjtriKZ1XjjI8AQ
         IDHCZ4T4CQ690v/GkTlM+SzddlmWlITjiXg4ZYmWA2n+XHAqgCFp/LVQD+I6/9QVhEhs
         M/suiVr0OKaWGN2Zuu3FT+THC+FXyUi1ehRFL6BrzNF6LO2VAvmpW6/Gvzb7fQGM1YXd
         XOTA==
X-Gm-Message-State: ABy/qLaXkWOsJzOecwCaG7infuUfXOhpbF29aW14XkQMdflmZSjro5Rb
        L+LGOhyA1zzpgLuLd40yU94e
X-Google-Smtp-Source: APBJJlFkW+yhcw5ylGow/CbTw0mSkaS+eN+VAZvgCsFAbr1u8TvxpY5Q2HMXr34JCpqgNW1lABFBPA==
X-Received: by 2002:ac8:5e0d:0:b0:403:3b39:45a0 with SMTP id h13-20020ac85e0d000000b004033b3945a0mr24971831qtx.33.1689717689286;
        Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l24-20020ac81498000000b003fdebf1a634sm910209qtj.75.2023.07.18.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:28 -0400
Message-ID: <ed0f1aaa999340e2e9ee34aa7a60754f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 18/20] selinux: nlmsgtab: implicit conversion
References: <20230706132337.15924-18-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-18-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use an unsigned type as loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/nlmsgtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Loop iterators ...

--
paul-moore.com
