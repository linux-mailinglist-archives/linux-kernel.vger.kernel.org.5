Return-Path: <linux-kernel+bounces-1106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD197814A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517671F25546
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62053173E;
	Fri, 15 Dec 2023 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="AfKlD1Lv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724F31735;
	Fri, 15 Dec 2023 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1242; q=dns/txt; s=iport;
  t=1702650517; x=1703860117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rtGpcSBAa+bZIu1Cx5ZRUunKjM+Koy2IkGWED7zM6Sw=;
  b=AfKlD1LvbRzFg0FtEl/tq5u/GcQVAyAup/9E326afrAAMWc5wNp0RYHG
   H3JoWj5Sh1MVSzQ9XWTSkK/hjb0I+pJPaNpAeaPPGBS+pRBOK2vlEXllI
   mCyOlzADe2u9hE2uTkhonatSGyhcBRBDjRYpZmwgiPjPA5rASqBtXerHi
   E=;
X-CSE-ConnectionGUID: Ea8JoieSQcKM1hK/F0wyog==
X-CSE-MsgGUID: 2lIXEF/3RZmN8Lx+OVNwdA==
X-IPAS-Result: =?us-ascii?q?A0AbAQADYnxllxbLJq1aHgEBCxIMQIFEC4IRgSNWLhJIB?=
 =?us-ascii?q?I1KiGqSWoslgSUDVg8BAQENAQE7CQQBAYUGAocxJzQJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQYBAQUBAQECAQcEFAEBAQEBAQEBNwUQNYVoDYZGAQIDOj8QCxguV?=
 =?us-ascii?q?wYTCIJ4AYJeAxGuO3iBNIEBg2sPrzKBYwaBSIgbAYogQoFJRIEVgyo+imQiB?=
 =?us-ascii?q?IZ7gh4HMoEJDAmBA4MmKZFrWyJGcBsDBwN/DysHBDAbBwYJFBgVIwZQAgIoI?=
 =?us-ascii?q?QkTEkCBXYFSCn4/Dw4Rgj4oNjYZSIJaFQw0SnUQKgQUF4ESBGobEh4SJREQF?=
 =?us-ascii?q?w0DCHQdAjI8AwUDBDMKEg0LIQUUQgNCBkkLAwIaBQMDBIEwBQ0eAhAaBgwnA?=
 =?us-ascii?q?wMSSQIQFAMeHQMDBgMKMQMwgRkMTwNsHzIJPA8MGwI5DScjAixWBRACFgMkG?=
 =?us-ascii?q?jYRCQsHIQMsBjgCEwwGBgleJhYJBCcDCAQDVAMjdxEDBAwDFwcLB1cDRB1AA?=
 =?us-ascii?q?3g9NRQbbaJSgTYBgxtZUIEaExcpliMBrwyEGYwFlSJJA5cZklmYRY1omkoCB?=
 =?us-ascii?q?AYFAhaBYzqBWzMaCBsVgyISQBkPjjmBEwEIh1eKZ0IyAjkCBwsBAQMJimEBA?=
 =?us-ascii?q?Q?=
IronPort-Data: A9a23:JeBLWKts0qdEzzBx6FishubU9ufnVL9ZMUV32f8akzHdYApBsoF/q
 tZmKWmBO/7eYGT9KNF/O4zgoxtX6JLXzINkQQs9qSk2RS9HgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0rrav656yAkiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuHZDdJ5xYuajhPsvja9Us21BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 44vG5ngows1Vz90Yj+Uuu6Tnn8iG9Y+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlCSuJyxyEzLSELn4NA3DGJxE9UH6+F4VDQmG
 fwwcFjhbziKivjzy7WhR6wwwM8iN8LseogYvxmMzxmAUq1gGsCFGf2Ro4UCtNszrpgm8fL2b
 s8YYidrZQ/oaBxUMVBRA5U79AutriiuKWYC9wj9SawfuWzy/CFfl+PXAt/zKviaBuJruFmUj
 zeTl4j+KkpHbIPEk2XtHmiXruvLgybTXIMJCKb+8v9snU3VymENYDUSVF2msby1jUWWRd1SM
 QoX9zAooKx081akJvH/QgakoXifoh8AR/JfFOo17AzLwa3Riy6cAXIOSRZOb9spsMJwTjsvv
 nePk97yDCFrtryYU2m1+bCToje/fyMSKAcqYyYYTQIDy9ruuoc+ilTIVNkLOKWylNf4BRn03
 DbMqiUi750LhNIA16ig1VTGmC634JzISBMloAnaQAqN6gJ/eZ7gZIGy71XfxehPIZzfTVSbu
 nUA3c+E44gmF4yWiGmDR/9IGLCv+uatLjLRmxhsEoMn+jDr/GSsFahZ5DB1KV14MsIsdjjub
 0ve/whW4fd7NT2qbKl7aYWrBOwxxK37CNLqEPvTa7JmaJV3cgjB+CZ1fk+W93j3l1Qrl+c6N
 P+ze8SrF3BBPqtn5CKsQPsa17oixyR4zmTWLbj0xg62+bWXfm+aVLBDNlaSBsgz67qZpkPb/
 tBQH8SPwhRbFub5Z0H/+IoePRYFJGk9AorepMled+rFKQ1jcEk+BvPKxrUodaRqmq1UkqHD+
 XTVckhaxVb2rX7KMwOHbjZkcryHYHpkhXs2J2ktJVGyxz0laJrp56YEfJxxdr4inAB+8RJqZ
 9QMK+eHA/l0cz/k3m0dTt7T9JNzcxv+0GpiIBGZSDQ4epdhQSnA9dnlYhbj+UEy4syf65NWT
 1qIiFuzfHYTezmOGvo6f9qJ6zuMUZkhdABaAhCgzjp7IRmEHG1Wx8vZ1KNfHi30AU+frgZ2L
 i7PafvimcHDopUu7P7Cjr2eooGiHoNWRxUCRTSEvejpbHWKrwJPJLOsts7WJFgxs0uqoc2fi
 Rl9lqiU3AAvxQ8V7NQkS96HM4pktoWxz1Ol8uiUNC6WNwvwUOwIzoiu1shUvaoF3a5CpQazQ
 QqO/NIcUYhly+u7eGP90DENN7zZvdlNw2G6xa1scC3HCNpfoePvvbN6ZELX1kSw7dJdbesY/
 AvWkJVMsFzj10tyYozuY+I93z3kE0Hsmp4P7vkyaLIHQCJyor2eSfQw0hPL3aw=
IronPort-HdrOrdr: A9a23:Jf+cha+mPhaclPTgDcJuk+D3I+orL9Y04lQ7vn2ZhyY7TiW9rb
 HKoB17726XtN9/YhsdcLy7VZVoBEmskaKdgrNhXotKPjOGhILAFugLhrcKgQeBJ8SUzIBgPM
 lbH5RWOZnZEUV6gcHm4AOxDtoshOWc/LvAv5a485+oJjsaEp2JKGxCe2CmLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3ABTKwDGkwtJoYBvThQlyoJrOhjnzXOVDUnFXXIkK?=
 =?us-ascii?q?DMG1KbeSVahi+oLx1lMU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ArQek7w0rU18T4A+NZln6zXWjLzUjuaCPOG0j1s4?=
 =?us-ascii?q?8icyiZQhgeBCjqiu7a9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,278,1695686400"; 
   d="scan'208";a="9923272"
Received: from aer-iport-nat.cisco.com (HELO aer-core-4.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:27:05 +0000
Received: from localhost (ams3-vpn-dhcp3724.cisco.com [10.61.78.140])
	(authenticated bits=0)
	by aer-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3BFER4AZ022079
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 15 Dec 2023 14:27:04 GMT
Date: Fri, 15 Dec 2023 16:27:03 +0200
From: Ariel Miculas <amiculas@cisco.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] docs: rust: remove `CC=clang` mentions
Message-ID: <am3aewoqtx2tzcdn55lzhqszhmtfqx5phwufo4bwinrslwe3ft@jahi4gp25sqf>
References: <20231215124751.175191-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215124751.175191-1-ojeda@kernel.org>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.78.140, ams3-vpn-dhcp3724.cisco.com
X-Outbound-Node: aer-core-4.cisco.com

On 23/12/15 01:47PM, Miguel Ojeda wrote:
> Nowadays all architectures except s390 recommend using `LLVM=1` instead of
> `CC=clang`, and since commit a3c6bfba4429 ("Documentation/llvm: refresh
> docs") the Kbuild LLVM documentation makes `LLVM=1` the way to go:
> 
>     We want to encourage the use of ``LLVM=1`` rather than just
>     ``CC=clang``. Make that suggestion "above the fold" and "front and
>     center" in our docs.
> 
> In particular, that commit removes the examples with `CC=clang`.
> 
> Thus do the same in the Rust Quick Start guide, i.e. remove the `CC=clang`
> mentions, especially since the architectures that have had their Rust
> support upstreamed (or soon to be upstreamed) are all `LLVM=1` ones
> anyway. And perhaps by the time Rust is supported for s390 (or new
> architectures), it may have moved to `LLVM=1` anyway. Otherwise,
> this can be added back if needed (or perhaps an extra link to
> Documentation/kbuild/llvm.rst).
> 
> This should also help avoiding potential confusion around `CC=clang` [1].
> 
> Link: https://lore.kernel.org/rust-for-linux/6df6e8e5-8d5b-4d3d-91b5-bc0e90c424ea@nvidia.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Ariel Miculas <amiculas@cisco.com>

