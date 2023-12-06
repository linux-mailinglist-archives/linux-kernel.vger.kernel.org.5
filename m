Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57DA8065CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376523AbjLFDkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376518AbjLFDkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:40:49 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A91BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:40:55 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d8a772157fso29478787b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 19:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701834054; x=1702438854; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=cVij1/NvE18svESYJcMkDdCpjO1aAk8ndvaSmV5pZ7+rJuMgDH1LaVsH+a68xE3YzW
         vZX+AOTQyny5SvsAuqtVUxSOMt0lbM0a5/DNDzVrfn7G3uoXqpSy+iStP/U1N3m400Wn
         3KeBPxHcgvvNAyR8ng0HTcsmVcCuM0OtztOmQyDIuWzwGYlRQ8cWSbGJOwIvzUIbtXm4
         5+ZwzMObN9oRroAEVx4HLLh19REUJl4nlgnExfTd8spRji6R249y9Re5REK2yHLWobRp
         ljIoaDtufv5TxScwpcH/zJVRYyDuERB2Oz8u7NO8eEckuYU2C/ZwZ8J98v8w4qRifwBc
         b93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701834054; x=1702438854;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aA6huiGocNu7EQwpUsqFk3t3njZJowfv7VE74cnDdTA=;
        b=DDlRB3RqyulJCWvarX2Ts954t2gP1v5LKoiv1sk1yOSNT5ZRKkYTJXk/OxhJHfgMFH
         NWBxNoGAvN+wBr9Zh+6oJSEfnOC909Vw3s3miWOvEkt1/NTW4r7O+IlDTIEie7bIp3PR
         A6YXObbb1qxRJoiAFqC5XFvsWAijYX/qD84xPuubLi+A4NKaP4nIOPbkM8Gz6onhtUFH
         YQcCF85mfGnx5FhfbRaaIgioC9sWZA32ZWN3cuJ8ev7UuEyoyOjjlEgDcav+I92eax5V
         AF0k9sLI7+ja/ijru0uGf9Fpbpyakbb3bX7GUQq78p4Qj6w/JWr3s4dU+ztVKSoZdaoZ
         PcLw==
X-Gm-Message-State: AOJu0YyZbzdttVGz1cZl5hlbDxmZhSw2+kYANrtbYZiFoC+lAwwQAOvf
        pYAcukhPhvAxNb0badYuafEM8/5rZMcU/a9O
X-Google-Smtp-Source: AGHT+IHaC+ru0qoQ9h7M+/3x7r27Q4yewk8aqqF4hA9Dhv9egf2BApCV53bcBqc4r19oCIE/j/UMmQ==
X-Received: by 2002:a81:4f84:0:b0:5d7:1941:aa2 with SMTP id d126-20020a814f84000000b005d719410aa2mr197337ywb.61.1701834054486;
        Tue, 05 Dec 2023 19:40:54 -0800 (PST)
Received: from smtpclient.apple ([43.132.98.41])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170902a98c00b001cfb41589d5sm10875188plb.27.2023.12.05.19.40.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 19:40:54 -0800 (PST)
From:   1 z <hodgezhong@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: 
Message-Id: <1FFC5A93-056A-4F73-BCF9-C16F30C1217B@gmail.com>
Date:   Wed, 6 Dec 2023 11:40:41 +0800
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subscribe linux-kernel
