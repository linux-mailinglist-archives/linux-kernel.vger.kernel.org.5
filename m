Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B157A4BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjIRPWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjIRPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:22:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B525BA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:20:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso29421001fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695050397; x=1695655197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFchyKYZaSrX7EMCsBGCn2uZcmTzjow+NxNlenZjDxg=;
        b=cIwHgRhAz6sOBu39XQ1hiE4Ft8pHDGcngD4epnGhkTmgqpp7SzB+DE2ZOZQEuwAc/7
         iCK/5dLUFZZQ2tQ89n3it+R7wNK5SBBVzo9+JANqutSiVOCvFxLkqNEn/r+5ZVI8whNE
         eWpAjsPExAj05feXex5pQn+6eFXb/YD664qlkRUzUgV2S1YfVFXTATBgPztgvtqagRi1
         cv5zBUtxrWVdTyK2ZVFH9KkgWaDveJ4KKasl8b53fDuSj9CmDQH4FMlFAaMWvMsbQ0Nm
         wwmQEhZNpHgfchHKEqHjzV153XyBXyIBV8oAVhos1YBY2KSEcz7+WOUEobdQ3byrPp0k
         VlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050397; x=1695655197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFchyKYZaSrX7EMCsBGCn2uZcmTzjow+NxNlenZjDxg=;
        b=ejCuA7QMWkkOJJowyxYmPFWUWHspP+KGoBfxgvsXDJBC9nIimc8Ge09b1TZz/+Pze3
         yd+fXW4FfEevB2NHQhxJcj3pFWXp/5kfpIXzCB+eYU97+3eS8AChC4LhcMu81lCMp6Pv
         p363JdiZkdBJ4wpA/xfiqRIzhIKvfiOj4bEth8l/hAXZbgYgJgw47Ks1A/J44sIdNhCl
         fJ1O+H11W81rphTsIWYRpXqoAF3uWXH6yGz3NoQ/NV92ufAmZPwk77EAPoMw3E/n+A4z
         P46C4ES4lo/ZMhn7Z+3PBVyF7k2wr3nS79IFk8rbgFJ9/WZY9VYKrs86BxG4yI0TM2fZ
         shlw==
X-Gm-Message-State: AOJu0YymHWKeZb1kOSCMQuxPHVgkbV9zOL9a71WznPPgwbK4Id0tCwc8
        uv/tXd4oi62eGjvkEAIMnAalZCM9TV1zFxOTZ2s5XQ==
X-Google-Smtp-Source: AGHT+IGZY9EAv9fq5jtqbWievBVWv5LiwqHR3LyOgh3sgu5FxK83H5apmVz53SdQ15aJu5RB2fhOsg==
X-Received: by 2002:a05:6402:28ac:b0:530:8d55:9c69 with SMTP id eg44-20020a05640228ac00b005308d559c69mr8040854edb.11.1695046714597;
        Mon, 18 Sep 2023 07:18:34 -0700 (PDT)
Received: from localhost ([82.150.214.1])
        by smtp.gmail.com with UTF8SMTPSA id f23-20020a056402161700b00525503fac84sm6031869edv.25.2023.09.18.07.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:18:34 -0700 (PDT)
From:   David Gstir <david@sigma-star.at>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     David Gstir <david@sigma-star.at>, Shawn Guo <shawnguo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        sigma star Kernel Team <upstream+dcp@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        Li Yang <leoyang.li@nxp.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/3] DCP as trusted keys backend
Date:   Mon, 18 Sep 2023 16:18:22 +0200
Message-ID: <20230918141826.8139-1-david@sigma-star.at>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revival of the previous patch set submitted by Richard Weinberger:
https://lore.kernel.org/linux-integrity/20210614201620.30451-1-richard@nod.at/

v2 is here:
https://lore.kernel.org/keyrings/20230912111115.24274-1-david@sigma-star.at/

v2 -> v3:
- Addressed review comments from Jarkko Sakkinen
v1 -> v2:
- Revive and rebase to latest version
- Include review comments from Ahmad Fatoum

The Data CoProcessor (DCP) is an IP core built into many NXP SoCs such
as i.mx6ull.

Similar to the CAAM engine used in more powerful SoCs, DCP can AES-
encrypt/decrypt user data using a unique, never-disclosed,
device-specific key. Unlike CAAM though, it cannot directly wrap and
unwrap blobs in hardware. As DCP offers only the bare minimum feature
set and a blob mechanism needs aid from software. A blob in this case
is a piece of sensitive data (e.g. a key) that is encrypted and
authenticated using the device-specific key so that unwrapping can only
be done on the hardware where the blob was wrapped.

This patch series adds a DCP based, trusted-key backend and is similar
in spirit to the one by Ahmad Fatoum [0] that does the same for CAAM.
It is of interest for similar use cases as the CAAM patch set, but for
lower end devices, where CAAM is not available.

Because constructing and parsing the blob has to happen in software,
we needed to decide on a blob format and chose the following:

struct dcp_blob_fmt {
	__u8 fmt_version;
	__u8 blob_key[AES_KEYSIZE_128];
	__u8 nonce[AES_KEYSIZE_128];
	__le32 payload_len;
	__u8 payload[];
} __packed;

The `fmt_version` is currently 1.

The encrypted key is stored in the payload area. It is AES-128-GCM
encrypted using `blob_key` and `nonce`, GCM auth tag is attached at
the end of the payload (`payload_len` does not include the size of
the auth tag).

The `blob_key` itself is encrypted in AES-128-ECB mode by DCP using
the OTP or UNIQUE device key. A new `blob_key` and `nonce` are generated
randomly, when sealing/exporting the DCP blob.

This patchset was tested with dm-crypt on an i.MX6ULL board.

[0] https://lore.kernel.org/keyrings/20220513145705.2080323-1-a.fatoum@pengutronix.de/

David Gstir (3):
  crypto: mxs-dcp: Add support for hardware provided keys
  KEYS: trusted: Introduce support for NXP DCP-based trusted keys
  doc: trusted-encrypted: add DCP as new trust source

 .../admin-guide/kernel-parameters.txt         |  13 +
 .../security/keys/trusted-encrypted.rst       |  85 +++++
 MAINTAINERS                                   |   9 +
 drivers/crypto/mxs-dcp.c                      | 104 +++++-
 include/keys/trusted_dcp.h                    |  11 +
 include/soc/fsl/dcp.h                         |  17 +
 security/keys/trusted-keys/Kconfig            |   9 +-
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     |   6 +-
 security/keys/trusted-keys/trusted_dcp.c      | 311 ++++++++++++++++++
 10 files changed, 554 insertions(+), 13 deletions(-)
 create mode 100644 include/keys/trusted_dcp.h
 create mode 100644 include/soc/fsl/dcp.h
 create mode 100644 security/keys/trusted-keys/trusted_dcp.c

-- 
2.35.3

