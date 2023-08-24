Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C655E7877D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjHXS35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjHXS3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:29:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2916F19BF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:29:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26d50a832a9so51453a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1692901770; x=1693506570;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1YcSecukI/DFCrztrORLNsZGL+keJIV6eV7Ksjr9Gk=;
        b=BOqwKncfGAv7/sk10fo5h2uyW0w/tgq6WrtbnuolTn8KoRL9jeuPUXIby9JnccqFq3
         CJHaRQTUzGjOy+/HSYJSbQnHhhApCmRk9X1EKYcx4HgrRH3HCGU/GL9P21pxsMRmJQ+e
         TxS+zIrVgqZmXS/K7OWgaxaH4QqkwdK6noTPb+IYTTDrjjPT2rFT7IpfzZOsP2FJkWld
         QmJ8/Yi7gahlB5c723fPBLLGaWi6WHhe+LvqlXg+XcXjTuoGQApRIyLCY/6hyoAi/iKg
         hMw+8S8hD2PiK4OJg103GUAMSZ9Q7OK40HoX4dQ3i19KF0D7DDW6EwiwC4eG86/Kd/TU
         AftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901770; x=1693506570;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1YcSecukI/DFCrztrORLNsZGL+keJIV6eV7Ksjr9Gk=;
        b=GlfCuADTfVBTp7jjsy7nzH/pwNdGKuJ95p2Tprlg2J6xHukAzfxJxojgYmK2nuzMOw
         ZloZYnQep6w1PiqaGeqVp2DzcpIA/ptdGOxkatVWIR1Rpqw/oWRbAauwLRNwUGF7oTL7
         iyJGAe8Pcv9rO06PUSox2tWXXU+sBvnsej/a8zLrxLWiVq9JaIHyxVn2cNpAYlODWYlt
         zd3Mfk8Y2ewenum9zNYOLsfbmyUI7IqWK3+MULSxM1h9lSKdM7Grciy7uGKg1YEtOjg4
         8MUko3mf21DYaXD5ABVOcC/i6nb99VHsRyTHy7BEBw/RXhV3TZQ4iqA7ls4b46hdskfg
         8oFQ==
X-Gm-Message-State: AOJu0YzRpS/3CEbojeyfz1sHgmqtSSjyKFEBL+GJ81JtPsL0i9hlGoba
        7sfD0ihk+h1/d9QDLDPgyyY7uccNQL6lRREXBKc=
X-Google-Smtp-Source: AGHT+IEj3DSxzNiMBroPsK0WsOrwhwhGUAIwXhWz1yAAmXCG0m396XZ+r/VKHLDvYZfeoEJd6N/nvg==
X-Received: by 2002:a17:90a:dc05:b0:268:a691:412f with SMTP id i5-20020a17090adc0500b00268a691412fmr12818362pjv.39.1692901770550;
        Thu, 24 Aug 2023 11:29:30 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0026b3773043dsm46714pjj.22.2023.08.24.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:29:29 -0700 (PDT)
Date:   Thu, 24 Aug 2023 11:29:29 -0700 (PDT)
X-Google-Original-Date: Thu, 24 Aug 2023 11:29:28 PDT (-0700)
Subject:     Re: [PATCH v5] riscv: Handle zicsr/zifencei issue between gcc and binutils
In-Reply-To: <20230824-cortex-mobilize-8b94e059e130@spud>
CC:     xingmingzheng@iscas.ac.cn,
        Conor Dooley <conor.dooley@microchip.com>,
        patchwork-bot+linux-riscv@kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, bmeng@tinylab.org, guoren@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-a2e62840-6065-4435-a82d-b09054e8f254@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 11:05:13 PDT (-0700), Conor Dooley wrote:
> On Fri, Aug 25, 2023 at 01:46:59AM +0800, Mingzheng Xing wrote:
>
>> Just a question, I see that the previous patch has been merged
>> into 6.5-rc7, and now a new fix patch should be sent out based
>> on that, right?
>
> yes

Ideally ASAP, it's very late in the cycle.  I have something for 
tomorrow morning, but this will need time to test...
