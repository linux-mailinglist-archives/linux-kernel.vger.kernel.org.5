Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD687DC222
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJ3Vvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjJ3Vvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:51:39 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5E1119;
        Mon, 30 Oct 2023 14:51:30 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2cf67be2so3211791a34.2;
        Mon, 30 Oct 2023 14:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698702690; x=1699307490; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XU6YDGeI4+wBW6QcdXCx4BV1CZFjMKR0ks808HcPwwQ=;
        b=MNqtA8OLfMT9W2eDB5mBNGV5spw19L7tc9YBCjNFkxJJJTTkt8B1hGUzu/AY3HL85A
         bZl+Fwb5mbIL+Uo/J9OzzNcDwtrFBEDA0TPqyNZyZXmY/eT0clhulJaTT3XXFsaeAbMD
         6B87tLX3LtWItTyqFm2J9MppBERAqOfNvs8Dymvoh/z0vwto/G5Ye8NyPzmIuRug0A/2
         tv6zlF3i3ttP1gMBjESolPuGDZW1v8g3ajl6tHo8edRKO7hVuc+eti1PwfDnRE6hXUvJ
         Yfvm1Qu1vlm6TVhs3exPyzfUDWiA+oUnPD1fe+0wW3CpbxRF/ZV32fe9JPP5lwFUy/V1
         Mvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702690; x=1699307490;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XU6YDGeI4+wBW6QcdXCx4BV1CZFjMKR0ks808HcPwwQ=;
        b=M3jFnBEbxpnd28zuEnkfRcWKwG2GI99kyRjP1+C/G/ezSwOR/43YaYs9Cdwn2LLxTK
         LYNYHBXOU6TMiesobj/lkMGfsFSf6nflc7ASwkPb/Apd6DaYMOLPeb2HXX/RweM6xXAB
         JGyllcM55GB5/14aQQ3+ArZYM7wjQgiUF6iA2/ggv7hkYp+VRperYq6nU2Zw+1vUyEMv
         rJ+k1hFurEPuQ1tlifu249EtW98WY/lshcAuS+O9HKTaZz1wIESowiACBmKQAD+MFaVS
         y7V1z8wmbrkiRmeu/ZLegzhUDBT/meVvVMcyu514vjFPLx8uDBlS7xrkeYDdx6zzSZNT
         fiHA==
X-Gm-Message-State: AOJu0YzARsveJSmcUeuYR3Mspcvb43yuLVTAVEHJ266TUwZemWjH8HmE
        Lb5qCkO4NkpsF03skQTZzQ==
X-Google-Smtp-Source: AGHT+IGLVz1d9Q/Rkzo8IbHTLi8FgvNKF2npO02/ws7LHL6ufzuWyDYmYF4cPmxCUtROBTpN+rPnGA==
X-Received: by 2002:a05:6359:2c44:b0:168:e9e5:b407 with SMTP id qv4-20020a0563592c4400b00168e9e5b407mr9778121rwb.10.1698702689775;
        Mon, 30 Oct 2023 14:51:29 -0700 (PDT)
Received: from n191-129-154.byted.org ([130.44.212.103])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a22ce00b007776c520488sm3692396qki.9.2023.10.30.14.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 14:51:29 -0700 (PDT)
Date:   Mon, 30 Oct 2023 21:51:27 +0000
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Youlun Zhang <zhangyoulun@bytedance.com>
Subject: Re: [PATCH net] veth: Fix RX stats for bpf_redirect_peer() traffic
Message-ID: <20231030215124.GA1626574@n191-129-154.byted.org>
References: <20231027184657.83978-1-yepeilin.cs@gmail.com>
 <20231027190254.GA88444@n191-129-154.byted.org>
 <59be18ff-dabc-2a07-3d78-039461b0f3f7@iogearbox.net>
 <20231028231135.GA2236124@n191-129-154.byted.org>
 <94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94c88020-5282-c82b-8f88-a2d012444699@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:19:26PM +0100, Daniel Borkmann wrote:
> OT: does cadvisor run inside the Pod to collect the device stats? Just
> curious how it gathers them.

Seems like it reads from /proc/$PID/net/dev:
https://github.com/google/cadvisor/blob/d19df4f3b8e73c7e807d4b9894c252b54852fa8a/container/libcontainer/handler.go#L461

Thanks,
Peilin Ye

