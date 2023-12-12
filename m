Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7623980F7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377224AbjLLUQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLLUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:16:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE9B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:16:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so3981342b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702412175; x=1703016975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxOv0gx7oEKxgwICBUwKf3ElEH298He0PEMzWMKMKww=;
        b=ER9vo/WTxMXvaISoHpB37bKEz9Q0kZJZPflr7f2WqJdYaq4fgzCxKPdLKfYbnLgrZi
         5iXlLDlPbtBGiKKYu7VZgK+8ztScDBhDKHm5btJP4NlWSXJbP5krHdhOCDoQt+tovJJl
         kXBBBAOIsQ2t0jGiliu24Og0+pt3A/vjCWHexTkNAb0MXuQYYJFjbgUvvXrnXY/qlrVp
         FmP0MVagMtXLIeK9ec2ZtWy8epYFKPL4KoifixgDsmWMomlulB/eYYcZZXe/pJqW7a1V
         9Myz5nHze30krxR623p9ozJbInoctYJZK1GQjN7N9zmS8RK3WXTQObjy3vUde7YiyPze
         bTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412175; x=1703016975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxOv0gx7oEKxgwICBUwKf3ElEH298He0PEMzWMKMKww=;
        b=lCvL3QmltNVZ2ES1o4OowmDTqouULIw/LgjipVB2MwOMDnrpPTOnz/ZKlZKA5SJ9bn
         Wh3mR7h6VD3ewMeLXQHLpcXv3A6w4PrG8WwRdE7MU8xgg3gtUWYI0dHTZ0ZuqmMPwSfP
         TQVM9+mS7+6H+PdSOQ1Q1lxAOfsZ/DUAEDALuVXsFI/u3JHvn4tEPEscSGHO7L2bC8/o
         iscZHds8xM2FOivSlChimhtCPLsrJdDKkmPoAlaloVCdrDg5yTTj1xiFKe+e/Ux7g7ve
         Upx52CjEYXGkL7FZlKsVzOx6Nqa2a5FTJF0ic2fVN+tnYZH3JJIHd7y/eziKLRpq2Bjt
         SfdQ==
X-Gm-Message-State: AOJu0Yy+sRgbHpK+jTGgkpX7b+Eotc2l8MMUPIvYT4ntAT3ocKPaZ/bV
        d/xkWcUkhFeZzHF1KsPfHbc=
X-Google-Smtp-Source: AGHT+IGZOkJP4RX1VWd+RO3GumwWN3d1QFsbL6sKwonFwM1gCj89KzGsYHwDJIJBA0zEzAdtMCy0Ow==
X-Received: by 2002:a62:5f45:0:b0:6ce:f6a4:8e6b with SMTP id t66-20020a625f45000000b006cef6a48e6bmr2887573pfb.5.1702412174740;
        Tue, 12 Dec 2023 12:16:14 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b006ce358d5d9asm8832066pfo.141.2023.12.12.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:16:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Dec 2023 10:16:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXi_jPhQr9y_c8kH@slm.duckdns.org>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
 <6l7ytemuf3uluzh4ejugnrh4r2shjyvprrnkvxeesg5cgdarev@fo6bbbmwwskk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6l7ytemuf3uluzh4ejugnrh4r2shjyvprrnkvxeesg5cgdarev@fo6bbbmwwskk>
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

On Tue, Dec 12, 2023 at 07:06:48PM +0000, Aaron Tomlin wrote:
> I thought by design we want a rescuer kthread to execute on any CPU, no?

Well, it needs to be able to move around because it dynamically attaches to
the worker pool it's rescuing and needs to take on its cpumask, but it
doesn't have to be able to run on all cpus all the time.

Thanks.

-- 
tejun
