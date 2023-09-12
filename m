Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86779D79E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjILRel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjILRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:34:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366B110E9;
        Tue, 12 Sep 2023 10:34:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9138C433C8;
        Tue, 12 Sep 2023 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694540075;
        bh=9GHvDYyDgQ1uQgwUbBG3T6n5VLCoxKnTwH+ebGupVVQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Ue7JlDqOAGqimu3Kkt4LS/bVe302496Rc3b4FBkHFyp80FDSRPk6O5d8jr84wRCfZ
         iq9xmx0t/GMvCZfny0AAaTfzwpfXsruoUJcqu7ZpagXcyOwon2t6Wjv76YlFnY4E9k
         pBdjONPwb/Gd3Gjst5vn/JIiYshbbnlZo+dfFV/IOAgQ6MLC8CG5rua0EPfSwikja9
         DCjVoD0gbRHUI0p9pn2jrXjlqPEmIQuk7gWw0PWRBx0ifHeEn1KGNywEab2rD2bMyr
         Jx2GQTaUMFhGMPN/QHRn9nGFXY8m6hIp2yGvJMWR4/v1nkfaOCplAjoQdmd8pMaDRX
         Ti6LrS8+QAA8w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 20:34:27 +0300
Message-Id: <CVH4BKBIAG68.17652WFGQ44EQ@suppilovahvero>
Cc:     "Shawn Guo" <shawnguo@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Ahmad Fatoum" <a.fatoum@pengutronix.de>,
        "sigma star Kernel Team" <upstream+dcp@sigma-star.at>,
        "David Howells" <dhowells@redhat.com>,
        "Li Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Tejun Heo" <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v2 1/3] crypto: mxs-dcp: Add support for hardware
 provided keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "David Gstir" <david@sigma-star.at>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.14.0
References: <20230912111115.24274-1-david@sigma-star.at>
 <20230912111115.24274-2-david@sigma-star.at>
In-Reply-To: <20230912111115.24274-2-david@sigma-star.at>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 2:11 PM EEST, David Gstir wrote:
> @@ -101,6 +102,7 @@ struct dcp_async_ctx {
>  	struct crypto_skcipher		*fallback;
>  	unsigned int			key_len;
>  	uint8_t				key[AES_KEYSIZE_128];
> +	bool				refkey;
>  };

s/refkey/key_referenced/

No reason to obfuscate it, especially since there is no supporting
documentation.

BR, Jarkko
