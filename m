Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C76784ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjHVTwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHVTwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:52:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD32E49
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:52:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bf0b24d925so31762315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733947; x=1693338747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mj79u19U1U4+bCgsqwuiL/E7UA+mbWglprWKVX+Exf4=;
        b=O3ARyo1axclYQ89gWNm8Zwf6gkP1DANEHW39BvR5Wf/FtIdyZFeRnyM5DbIeNXSmN7
         1yMf0r1vE119jEnoZWQxPT+9ZfinQXc7ZhKk+dB+eXBwEilm8LNnw2n35NtXvOukKcG2
         iQDirA0ADaCc1nEUw2qucU6CfdDpnL6o/hZrWEa6TI0ZZpHyjE2zvhq7DWDoDuEpxPqv
         BLEQluacmB70f7tHPn0ADbYVVGM0RWPAkzQZR4u/zAuax2lPwIYS5B5nWRnxpHgnjyzS
         sDPBlkteuQaoZHASsrBUgDGZizYkurTJ8ZwIbnk37HSHSh862SASasP7K4CGPX+gOaDO
         Av7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733947; x=1693338747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj79u19U1U4+bCgsqwuiL/E7UA+mbWglprWKVX+Exf4=;
        b=jQMudH7lf1l0ptppLIyoDZa9tfDoIeSkP/SHyVvAj6FzHdUyqH30imCHyIrUZ6m3aJ
         E24kKh2cZq8VZ838jd4IzqlcMujfJDdMgzko8jMsdHPqp4uGScoISFzL6HWEBwojFbmv
         VaMWFGuqjjgIMIpWn20YtgQ4sbV3s0+s7lGqwSggDmGa6A5dPvG5AwHMLNkQrlVWH/yc
         JrZ2xEPzGA+EOEmua3wC25upPTAwdaViWDN38xiqhu76CbysRopapi4BfiHXXajeIM6Q
         aLzcGY5wgxeJmEhubLnttkNov6EwuCVt6a/yvt6Idrw2OtGV171NKuldP3zX4Yz75jbj
         DOcQ==
X-Gm-Message-State: AOJu0Ywe0NQiGyRjvBgnPE93OBwKVG5tIPzaThdSHd8MmIc+Yhi0u3xd
        GwyczHmMJyAXtu1ZNhyc0QKYfvU3+Eo=
X-Google-Smtp-Source: AGHT+IGk/798bJLWGsoYDooLbi6g8Z4Kvdr7Xe2SGG9+irIKd+bu/MWXWAV6OxS4kNzlWYkPTl7ing==
X-Received: by 2002:a17:903:1c4:b0:1bf:205f:c02c with SMTP id e4-20020a17090301c400b001bf205fc02cmr9630825plh.58.1692733946702;
        Tue, 22 Aug 2023 12:52:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:8fa0])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b001bc59cd718asm9415283plz.278.2023.08.22.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:52:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Aug 2023 09:52:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [BUG] KCSAN: data-race in process_one_work / process_one_work
Message-ID: <ZOUR-Apz2Tws4d2c@slm.duckdns.org>
References: <6057c45f-d045-4772-db7c-3d706ada654f@alu.unizg.hr>
 <ZN6YVG114AZv9Yp8@slm.duckdns.org>
 <897214a4-ab16-a275-1023-4d38c3700b7d@alu.unizg.hr>
 <4ef130ef-b37b-2564-3cb3-6a930b2f729b@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef130ef-b37b-2564-3cb3-6a930b2f729b@alu.unizg.hr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 01:58:27PM +0200, Mirsad Todorovac wrote:
> Just as an exercise, this seems to work, but it is probably not very clean and not very scalable:

pwq is already per-cpu. It's not strictly accessed per-cpu because workers
can go unbound but given that it's a stat counter, that doesn't really
matter all that much. Sounds like it should be marked so that kcsan ignores
it.

Thanks.

-- 
tejun
