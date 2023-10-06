Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A186B7BB771
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjJFMRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjJFMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:17:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85778C2;
        Fri,  6 Oct 2023 05:17:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so15630025ad.0;
        Fri, 06 Oct 2023 05:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696594629; x=1697199429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOliDYSfdDjd8qPENuvroDgTApgk5BQpxPpwejVZeFQ=;
        b=MH0DFd6ACHbKdBeKavmmImFXwxUt/pt2aQBDnpP4ePw+WMsyJNHf3x+9CFHVCbxPvg
         8klP8YURbN5klJGxfSG3te2Eo42RZaZC1nXusUT8jhTMp3I4dx2LL/p7j5IQWH9xASoh
         eDbp5NaQhtpZFvkkkf1TMPeYNilfBfQsouI7FC5xw+7S97Ya9ug+Fr2MeWs7RgdvPZDL
         vNbjdmr5PTxImLJpCMixP1RKMngnKKPXgxs18eXRHZ24CWkHabjRcwP7U0HMuAaSzLoB
         rEdd5ciVk7IybWA2sX2QRgM2rVtuAivhoFD+U82Dxe9MJO5ZciH8NpppBm/jA3fAuVML
         oIZw==
X-Gm-Message-State: AOJu0Yyb8v2FbTrsC+8zhOH7zU1rTUa2iq/wk/zX47ipwctbvzulkLf9
        4IDRRFB7VHYdPW8EGpjDe9k=
X-Google-Smtp-Source: AGHT+IGpqLWRjfqW0a1Q63oZsAgBWs0TG5UVFflGSESYtARNtaAA7H4ylYwrFP7YDABFRj/NZcJzSA==
X-Received: by 2002:a17:902:d50f:b0:1c3:bc2a:f6b4 with SMTP id b15-20020a170902d50f00b001c3bc2af6b4mr9121885plg.42.1696594628907;
        Fri, 06 Oct 2023 05:17:08 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001b8b2b95068sm3679811plb.204.2023.10.06.05.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:17:08 -0700 (PDT)
Date:   Fri, 6 Oct 2023 09:17:08 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1696594627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOliDYSfdDjd8qPENuvroDgTApgk5BQpxPpwejVZeFQ=;
        b=Bvj2ZZmlAmcheOfr191AVtGk6RsvZcgU71VUMj7sbdUrqSjrgltToamVt70fjLzGKsWZyV
        kg1qq6c1/37JQu9fJx7HrCuZiEqGIBo3CWSvot6SZUr08393v4l3Z98dmLdctRhRTRtrBh
        EebfnWIFSlySCiJRb8NETGLLVSVbR7C+aRkGdxyGQozIxlmS9DyCoxBM6zZlJ5oss8V4Ts
        U79eL8Vq+IuwQigxogHjRHDwIk4yXEr/HRWYgpjaaugJ/7zy4qCYx2YTCeWXbHwo6ocDrj
        nuRXlnPo15YXScnDSAHYGFHWDEa+/Fv6uYhYZbxSGCY5WnYRHK7Awa6vu3+2pg==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>
Cc:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, pvrusb2@isely.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify
Message-ID: <cb6fm6c65rqbk6hzjii5bqanscy7njfu5k7nnpe4doxytshqpf@ulv5noywsnlv>
References: <000000000000a02a4205fff8eb92@google.com>
 <gugiuvjgpoogf3k5cm4px4jwevg5torsu3d7afbbhvnrxho4zu@wkcxeb5sr5ez>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gugiuvjgpoogf3k5cm4px4jwevg5torsu3d7afbbhvnrxho4zu@wkcxeb5sr5ez>
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 1053c4a4b8fcbd28386e80347e7c82d4d617e352
