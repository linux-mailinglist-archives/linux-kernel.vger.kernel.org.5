Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431147BCF72
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344396AbjJHR4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjJHR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:56:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB2BA3;
        Sun,  8 Oct 2023 10:56:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso2787463b3a.0;
        Sun, 08 Oct 2023 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696787771; x=1697392571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ3V3/WIgMOXNTQMLjEbSnI+9wH67IrtaCQKwXc776o=;
        b=Yx/SivypN+SmQ0hLXY2r5oqQxRBE3L2sJ9GgDNvbq/rSiF5pmyp4Ah+JugsCqvza+f
         WfqTa+KX4+Q5dtNE6TfStwxT2v7IcjeXIAled3hwIwDwxLwtU6z86KPsrbAkOgDkfXpd
         rTi8Gd8W9tjGCO8vl0eheCylKYoI5nZCLXyPhRti58I/JDOVzJMDnrONFtzof5ZlEIqq
         OBPHy1Hr2fUMhZf/HWekuNK3tg7HvblBCbPHF8zmtM89eRiWDnq853X9k7cY+/6LRWgj
         Id0VAjdOSgcSzlAYybHfA4X0OhzsQqUT+57FOBFlIdNhQ8ylp24WsCxcBonuvLNLora3
         efGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696787771; x=1697392571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ3V3/WIgMOXNTQMLjEbSnI+9wH67IrtaCQKwXc776o=;
        b=BF9FFmFzGorN8ZkhpJVi3DEyp1Dmy5pXwJATACYr49LgLvwgLp6uEzdfh44JsDJAuJ
         s0aNGC5BJ0R/cCXUgwZzNzw2EXDBKo4jAHq6Fe1+s8hhsH3W7CeajDDDEtDZzI5wMbnM
         cqED0zC4uXVYucFEYgjwTtgf9PvCQWW3X48qraNDCrj4+FfTPNA5FRPRPHUXsPjd9lno
         67NYD8e67KcZ5C/uUIT5+VoxvOr2tj/AYU1T/yWQPQfWKDc5+EEIjwdENRf/ifRiAIGu
         AuFI2/mpYT53nR3hQJ+oVViFRziCZ6afyuju8wZZCNlO6yOQSSUc9oVQhQhLi3UaZ1Sy
         NQ9w==
X-Gm-Message-State: AOJu0Yx5uVgAsVFIUxhwezZh3l2aRTP/BPCf0edxSzc7SNole4sWpIxK
        ixDqlmfJhwm5BMscmkjYc/Y=
X-Google-Smtp-Source: AGHT+IFQRUlCxOh9bg4szXxxTdkiXZAhyVLgLHbMhr1GVAVfukmQjzxuiJoHNl7g5ElNRKV330vluQ==
X-Received: by 2002:a05:6a00:1d85:b0:68e:2c2a:aa1d with SMTP id z5-20020a056a001d8500b0068e2c2aaa1dmr11798246pfw.11.1696787771033;
        Sun, 08 Oct 2023 10:56:11 -0700 (PDT)
Received: from localhost ([2601:647:5b81:12a0:a3e9:5a65:be6:12db])
        by smtp.gmail.com with ESMTPSA id k22-20020aa78216000000b0069337938be8sm4785516pfi.110.2023.10.08.10.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:56:10 -0700 (PDT)
Date:   Sun, 8 Oct 2023 10:56:09 -0700
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, jhs@mojatatu.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
Message-ID: <ZSLtOViO2p31Jzd6@pop-os.localdomain>
References: <20230926182625.72475-1-dg573847474@gmail.com>
 <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 05:01:07PM +0800, Chengfeng Ye wrote:
> Hi Jakub,
> 
> Thanks for the reply,
> 
> I inspected the code a bit more, it seems that the TC action is called from
> tcf_proto_ops.classify() callback, which is called from Qdisc_ops enqueue
> callback.
> 
> Then Qdisc enqueue callback is from
> 
> -> __dev_queue_xmit()
> -> __dev_xmit_skb()
> -> dev_qdisc_enqueue()
> 
> inside the net core. It seems that this __dev_queue_xmit() callback is
> typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
> already disabled, but sometimes also can from a work queue under
> process context, one case is the br_mrp_test_work_expired() inside
> net/bridge/br_mrp.c. Does it indicate that this TC action could also be
> called with BH enable? I am not a developer so really not sure about it,
> as the networking code is a bit long and complicated.

Doesn't __dev_queue_xmit() itself disable BH with rcu_read_lock_bh()??

Thanks.
