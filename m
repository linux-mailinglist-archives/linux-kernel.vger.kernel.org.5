Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0467B1213
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjI1F1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 01:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1F1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 01:27:18 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BF122;
        Wed, 27 Sep 2023 22:27:17 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a1fa977667so6756190fac.1;
        Wed, 27 Sep 2023 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695878836; x=1696483636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzesFe1jUNQkPNQFdz5fZZnHB3+mM1DdWesfa223dqw=;
        b=BQ2ljgXrtuBJOjZC6tQxEBme5CHiwvVhgfp75Ex9YEYWt8Ai4EBFkLVAGn6JfCb+lf
         nIH/1s4G7VIflbA1w00+qBobAd5UtWwAcOlmi1sYYymsr56z6DgDPb3RQKsid3TH+06c
         qD0F9N9gn86q7IWov/QFeopSD+b09c2fYq650KMypfKRYQ2RNTxMke/3gTXMdje68mTa
         rP5GUbqIhM+2jPm97GidPVWHZs9WlnBrdWWr91qGg1hxLb+EQpVYgstIaOk8J8ErQOVr
         uVHucof8LcHXcED40KJOtxLhLtwHOFKCb7MHo7qJ27Jf6OWNZ77TLNQsY/A0O8I3MoKF
         bz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695878836; x=1696483636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzesFe1jUNQkPNQFdz5fZZnHB3+mM1DdWesfa223dqw=;
        b=MvjwfzgbEykQI+HtihAVqhuAKveAJC8XEqsUOvvXDkrYXgShEsy20RBg+dyfCcxcyE
         C3Nf2Cc63RRbHsdlVlAR3bHrvBD99/iAn1vVtszbtBOy1ohWGMtV9MG0HiV8wC5yvlhz
         kHjHWpkULB6ubea4EekP+8r2Xyx0tw34gSI0jNgQeS1eADXf4Iq+rDs3cKNk21zNiH0K
         pR9q6vFVBtVtgdv5ARB7miQm0u6/0RZaMNFzJT//OT280HnRv2ZLIDVEeD1bJj2108ZD
         SMIvp0S+fS+AMBZwWW+K+lL9JEFORRHeekYHQnKrAFqtYWdQe3w0BqWDSNp2QOk9tSNm
         Fi3Q==
X-Gm-Message-State: AOJu0YxkOTN5BFjKf9Y3y70cwX3vJcVlR5EuPHJHQPSXr6YWnxKhC19Y
        ZNfaGa9Ou5ZPYRC51NjZQTU=
X-Google-Smtp-Source: AGHT+IFJXcHHA5X6azHZlNsxivV559BAGdYTUvTtxMNa7qEf5tC4yYwTjURVt2H1DdhShafl29eDig==
X-Received: by 2002:a05:6870:a3d0:b0:1d6:53e6:7c8a with SMTP id h16-20020a056870a3d000b001d653e67c8amr275275oak.14.1695878835722;
        Wed, 27 Sep 2023 22:27:15 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id k17-20020a637b51000000b0056b27af8715sm12106368pgn.43.2023.09.27.22.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 22:27:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1BF6281645D0; Thu, 28 Sep 2023 12:27:09 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH net-next v2 0/2] Documentation fixes for dpll subsystem
Date:   Thu, 28 Sep 2023 12:27:06 +0700
Message-ID: <20230928052708.44820-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=bagasdotme@gmail.com; h=from:subject; bh=OK23hv7Zwua1zwPy0Cj9i0AXbUnptkGgpi+7Mjq4dQw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmivF4PDRV3ffuQZH8ttTTxtaa5rNoJqbSHV2PCX5nr9 V+s+Pijo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABMRMWRkuHNm7c0ZOZfNo6JX mdplfPnmv3fyj70M702vPTh4jLFnWirD/6IN33wKrModZyV949r6QPBJIbtTfJOo10z9m/1c0Q6 HWAE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a mini docs fixes for dpll subsystem. The fixes are all code
block-related.

This series is triggered because I was emailed by kernel test robot,
alerting htmldocs warnings (see patch [1/2]).

Changes since v1 [1]:
  * Collect Reviewed-by tags
  * Rebase on current net-next

[1]: https://lore.kernel.org/all/20230918093240.29824-1-bagasdotme@gmail.com/

Bagas Sanjaya (2):
  Documentation: dpll: Fix code blocks
  Documentation: dpll: wrap DPLL_CMD_PIN_GET output in a code block

 Documentation/driver-api/dpll.rst | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)


base-commit: 5a1b322cb0b7d0d33a2d13462294dc0f46911172
-- 
An old man doll... just what I always wanted! - Clara

