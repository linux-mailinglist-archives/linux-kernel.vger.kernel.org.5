Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3096579461A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245008AbjIFWTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244401AbjIFWTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:19:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B419B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:19:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-402d0eda361so4241025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694038742; x=1694643542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU8cFIiD+Je1Pm21KKOZlauTJY9oyFCpoO1jilyDRLk=;
        b=MkAvPztzRVgLiqDQxQW92L/NKyE2fv5PwuOyLcwidmph3NEUCB32ScK0MYJbnoAANy
         8/pHYUB5ux32qWfAhQ6pV5p15rIQ+MY07R9xIAuaI+hNb4nCIQQ9lzCg1LNqAUcXGKtS
         l/AIRFRxP91qXCcCDOCXdflm1XrLVihUF+Aw1/yF9AA+6MxNl1Rar4LYhNPStyZ7MfxK
         3HlGczylQdFEqpIBTxdhhlCJBjmfGH01Vt3DYL38Tl76DdtHfo0Z3OEvmwFil/tcFuJe
         8HPOA8QQcy8eS2uBMJMwjI4zJM8JI4wY6gGfw4Hh98/7YK1F7OC/PcL4ShiOv0iG4Vus
         TnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694038742; x=1694643542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU8cFIiD+Je1Pm21KKOZlauTJY9oyFCpoO1jilyDRLk=;
        b=f7y1Mo3rU8KohP1p06p9tQ6JnlNy+G6iprBi/6V3NfbCj8CAHn1GfwC1yY1Z5/mLsD
         Kie9/F/EnZjlA1ybB5xvhM1UFejuMiRSpS2lMK7hU94ar/yKW3n5u+iN8AnM2MNOKyLy
         S7WmqtoF77EocMeXbM5nYE3GieAPZ8vts+G7GqFsu5Dn+mTnCJgVR1Pa9rDlecDLzKqV
         eJdpT2dJuc8j+MgkgKwgcc3fupNaUNMoUKphTFJVpyzgGUMIbUL1lD76VJzZaOqFleAm
         CQ7PItFpkccm5yCcPQPdWKSmIaRJwyu9hX+JRtJr83ZvdlixaOxCnFT2cBFVJ5uwqsmj
         L8ZQ==
X-Gm-Message-State: AOJu0YxnQbtO8OaM++XOhzEGjeiUL3wLJL4UcFSklCo4ngB1xj1UC90Z
        P5wra7EXDT12EVKt5ld6PPc=
X-Google-Smtp-Source: AGHT+IHswncGUitGySFNGj81BcL1BtuDIItL5AElRyPPvp8cVkU9YtFYA4jmfkTwVV81rGIAv7Dqrg==
X-Received: by 2002:a05:600c:3781:b0:401:d258:ad3d with SMTP id o1-20020a05600c378100b00401d258ad3dmr3484773wmr.2.1694038741675;
        Wed, 06 Sep 2023 15:19:01 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b00402e942561fsm688700wmf.38.2023.09.06.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:19:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 7 Sep 2023 00:18:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
Subject: Re: [patch 1/2] x86/microcode/32: Move early loading after paging
 enable
Message-ID: <ZPj60wgHT/CJv6Th@gmail.com>
References: <20230822121936.476984181@linutronix.de>
 <20230822121953.976548391@linutronix.de>
 <ZPj6biwRb30FKTyH@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPj6biwRb30FKTyH@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Reviewed-by: Ingo Molnar <mingo@kernel.org>

[ This was meant as a reply to the v2 patch. ]

Thanks,

	Ingo
