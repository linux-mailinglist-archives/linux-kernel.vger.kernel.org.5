Return-Path: <linux-kernel+bounces-9791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C881CB86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A671F22881
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10292374B;
	Fri, 22 Dec 2023 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNxAc1t/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6B23740;
	Fri, 22 Dec 2023 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so17502965e9.3;
        Fri, 22 Dec 2023 06:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703256663; x=1703861463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNp4E7G3he8UV4jpGDCQDUTxTixBCD4JOV37xRazdPw=;
        b=RNxAc1t/mCofFWyOII/xtudTHXXHfs2B4I3jGWhEh0cFZDX7cGjeB23BDGbHCeKQxE
         fpcYlOTPHySsRGEnNkccRjcph4xkkuSePqvpGfQOjVAnoKRAsiuPQG90VGgdPRg+hGsP
         I+yiRs8N9onKss4sLe1MDr9/S77kwwJ04061B+Jo3BzRfBp8P9mhI9Scjhomlkge/zu+
         SAWASghX6QNQIEw0OeCt77oIco60gh+79+nxObSjOEuDwDRREIOIGjwPjsbccYbWZwzh
         7NqT7bWEXgrFDNDaJemWrEk3Rq2WE9PLbeDzr5U0Y/uelAG885Wpzy9mbq/OMTGtuRRp
         Rg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703256663; x=1703861463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNp4E7G3he8UV4jpGDCQDUTxTixBCD4JOV37xRazdPw=;
        b=LOvKhXhpaAmDwc0MK+qMfdQ+HjsB6w9efoyVq35BSMaJbzjn0a1J5stxzmKXkZVUQp
         SQF2UfFEQNTSI65MaU1jtmO9DZMJBqZ3aHnQhlvySDhytc7eb7C6Z8OLr++f/WLKoJMm
         d0P9MBTvVBSJSb9LKf9pjW2A56n7U732kMVRg96Uzv0qOMRFLqpCxKixtNYcwfGR1XOp
         jmAWaVnPEM9+CLmq/gSKY3Iz60sMOd2E0qAypSenQrvRlj98e9wS2BbCuZbqn8PsDStS
         2V/PRoHBhmdZJx7uFWD2yMh4PLIPtnotPjZ8QIc3qIKYIFgW5GEQWpdgCEym4/RK43UW
         nZKQ==
X-Gm-Message-State: AOJu0YzIgF71hBhOC+DDO7JdEmSnVsGtIfr79mFLXcnVloCLqOVHxZdg
	TNho2pq6uCimYjMeim7uZM0=
X-Google-Smtp-Source: AGHT+IGwck3aN97hbUoaagXBuZKIstvcQ6Uu7YqkJpAZlMvwwphtTuaRf7/0nxAeG5R7YOHAdcawAg==
X-Received: by 2002:a05:600c:1390:b0:40c:2c52:ae3f with SMTP id u16-20020a05600c139000b0040c2c52ae3fmr848063wmf.19.1703256662842;
        Fri, 22 Dec 2023 06:51:02 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id jx23-20020a170906ca5700b00a269840ab2csm2112537ejb.208.2023.12.22.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:51:02 -0800 (PST)
Date: Fri, 22 Dec 2023 16:51:00 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: PHY issue with SJA1105Q/DP84849I Design
Message-ID: <20231222145100.sfcuux7ayxtxgogo@skbuf>
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>

On Wed, Dec 20, 2023 at 12:49:30PM +0530, Jagan Teki wrote:
> [ 1255.021656] Modules linked in: mdio_netlink(O) bnep tag_sja1105 sja1105 pcs_xpcs brcmfmac brcmutil imx_sdma coda_vpu v4l2_jpeg imx_vdoa evbug
> [ 1255.034578] CPU: 0 PID: 374 Comm: ip Tainted: G           O       6.1.58 #1

Can you please reproduce the issue with no out-of-tree modules used
(here mdio_netlink)?

