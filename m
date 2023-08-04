Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7476F664
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHDALH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHDALF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:11:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736EB3C20
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:11:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad356f03so11021765ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107864; x=1691712664;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RmgeNqR547q2Tkh2T4yVthFUiCUjaKYXLUc+QkiQ7s=;
        b=MDsDqNajZq6LK5/eZHN1+XZ4dpjJ+TI1kigNf8zcEvkBQj3ZKBt80mRBqKKQEi0dNQ
         SRR02CPAqOIiOwwD6GteLqv9cLWEALo3Y9PpTVpYaZde/ZngOKzFQK5s/sfvec1QdA6v
         pCNAX3+acYcvV8nRHYR3jwRLnVr97axAI23oZazP2O3/xhpvjfc6KQe0mo7JGM/9MTP3
         u3lEPpbPJYSjpud6CgNYlIYT6aEoaX+CAQ7OuzCGO6dzY/9GDkHKL00j8NiF9tygGbav
         gUq2jDHgCPqBddMlsY+SELEeq84gPrXAadbRIClgGwaXzG4ZOiSx4HLm7WJQ4MJryGjn
         LtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107864; x=1691712664;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RmgeNqR547q2Tkh2T4yVthFUiCUjaKYXLUc+QkiQ7s=;
        b=KU30hWDgco8tZXlzLxMwFGVR8RMVy8Rdo4mZOf3S7fio5dSDbCICuzNpVvTbCXihjA
         fm8sriGcGAMLIuFqCjwOVdbkXtnSgwdAoXh+IqFYWaeKoO8vFwXf5961d6UJixPeCAuR
         xgZGSQZKFWvWmZuIK2mt4NwHQN8HX0hOzAeW5Ui+Esjm4231d5PwP08sGMWXSIJRfJJT
         RKbH+W5Wom3wug+jZ8hivM0vwA4SRYLL38emK5WPSFZad9Hfy+WxJ0mJnRKsbp6CGQ2J
         6PBYfOuRdvTL2cgHGCw2Y9DXomZNkXbB/uXll7UNcJtsHYVgTWgNL7YL5BtdP3TfdQT2
         MYMw==
X-Gm-Message-State: AOJu0YyTrcCf+HxAg1VPIw5wJMKlmsgvBounj4M6G6aPCHDVFwlN8Olh
        G6Mj+jsqDQLoH0OR4NrNxyI=
X-Google-Smtp-Source: AGHT+IHu4Yv30EtL3vuiCE8ujlufFnbMLV0N7z1gJEFTwP8ADlryRmc1mdTsYoON1qF6z3dIV74Xsw==
X-Received: by 2002:a17:902:dad1:b0:1bb:4861:d3a7 with SMTP id q17-20020a170902dad100b001bb4861d3a7mr306898plx.16.1691107863739;
        Thu, 03 Aug 2023 17:11:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c14400b001b9be3b94d3sm407419plj.140.2023.08.03.17.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:11:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 3 Aug 2023 14:11:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] workqueue: use LIST_HEAD to initialize cull_list
Message-ID: <ZMxCFq1RHHi2Hc2w@slm.duckdns.org>
References: <20230803075135.499536-1-yangyingliang@huawei.com>
 <CAJhGHyDMoX6MfPiEBgJ_6CCCetCfFsas=TEQU8PfNuUjE9TH0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyDMoX6MfPiEBgJ_6CCCetCfFsas=TEQU8PfNuUjE9TH0w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 05:50:42PM +0800, Lai Jiangshan wrote:
> On Thu, Aug 3, 2023 at 3:54 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >
> > Use LIST_HEAD() to initialize cull_list instead of open-coding it.
> >
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

I don't have this patch in my inbox. Yang, can you pelase resend?

Thanks.

-- 
tejun
