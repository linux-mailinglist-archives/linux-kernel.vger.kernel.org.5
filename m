Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA080D788
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjLKSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbjLKSjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:39:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FC9CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:39:51 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28865456abbso3426061a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702319991; x=1702924791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnXPcTsmT/cm9SReN3VMxlP9k/6LTC9VBWFDGvdk3vc=;
        b=X7FbieZ5RMCBdjOI3aEtGzkFJz3YhHVfVDmGHgPZJB+vTB2FwiewZFVAA7VFiNHZHJ
         3RWOcNMzyu3uIeX8qJyZKpNMbvtHO7JHUCYkFZrz7mK7cBzzziKJDJ4jBHFvGl7Fuf0k
         vyve0fyXxQoTHy7RdLhDPUansPhB0PYToRfbTn5BGi1GqSo4Wfimt5QCySY3weW0rKek
         ce/HNPoRewcVxKfIy8waChv8UCMps2L1Vj45FlUnR2fh1V+PGnOfyOYIsEIe8JSzDtuO
         M0cpOMU0pNhPY/gGYXNLdj5Ih85SEiUhuk26/3mFpT8E5Zecp4lBMM4Q5e71G76FwuOB
         scSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702319991; x=1702924791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnXPcTsmT/cm9SReN3VMxlP9k/6LTC9VBWFDGvdk3vc=;
        b=b2vYJd0qjjlnEZRooxmFs54NSLUamQXrHm+BNxOGA42jBceZTD5WYM8VE9stSLW+hm
         qz3AKyiPbXrF2qa8eJIkYh9CvbQU3zD7KV0CxwbAU1OolG1wmCAwD3MImN3hJOV2HE8o
         +FubzMR7/8X+pUdhqqm4XxEczV1Yb55XT6BMquMMBzTZg9EmZX4n1/CLpZM7IMVu6Ezh
         m7eK3qYof1f7zHkQhctd31idTdoaHqo5rCsEhLStrcLkVghK3cBKb1kolWS4WAG7AteT
         dlaD/iUOigqPDkFUpJ87CxaqzZVTENd8AVqhxcDiZP/K9XnS1B7msnCEq6XQ0vLKsVOe
         QvMQ==
X-Gm-Message-State: AOJu0YxeYDjYs+zeB2u7eui6e8TYz7yatHlqKpO23IWNLg1OqBdjzlcW
        7qnIBW7B4FUxiW1tjS8N+3R77mYpqxk=
X-Google-Smtp-Source: AGHT+IEZ+D597fI3YkgertvHsMQ13vUm9XzxTBlLO7vz09KQJl1FzIz8kaDVHDpGppgPOfYAV7W4Qg==
X-Received: by 2002:a17:90a:d318:b0:286:bc9c:327c with SMTP id p24-20020a17090ad31800b00286bc9c327cmr2192183pju.22.1702319990941;
        Mon, 11 Dec 2023 10:39:50 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id mt20-20020a17090b231400b002853349e490sm8987614pjb.34.2023.12.11.10.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:39:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Dec 2023 08:39:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 11, 2023 at 03:51:57PM +0100, Juri Lelli wrote:
> Guess this is a requirement because, if workqueue processing is stuck
> for some reason, getting rescuers to run on the same set of cpus
> workqueues have been restricted to already doesn't really have good
> chances of making any progress?

The only problem rescuers try to solve is deadlocks caused by lack of
memory, so on the cpu side, it just follows whatever worker pool it's trying
to help.

> Wonder if we still might need some sort of fail hard/warn mode in case
> strict isolation is in place? Or maybe we have that already?

For both percpu and unbound workqueues, the rescuers just follow whatever
pool it's trying to help at the moment, so it shouldn't cause any surprises
in terms of isolation. It just temporarily joins the already active but
stuck pool.

Thanks.

-- 
tejun
