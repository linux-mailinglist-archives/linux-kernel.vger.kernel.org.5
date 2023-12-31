Return-Path: <linux-kernel+bounces-13763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F65A820C37
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7AB281A4A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B279449;
	Sun, 31 Dec 2023 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="niqGUSXP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CAE8F51;
	Sun, 31 Dec 2023 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704044422; x=1704649222; i=markus.elfring@web.de;
	bh=NPejmCOhVVhAeW/4/SItFS461+EicOMoTP7nv0qyy4k=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=niqGUSXPx80pf7w0cvuEFbyKp2GhvjieQpJ0mguKM6G3KGtdm90J+kDte0Oq9bve
	 d6vtW4XfQkg4qSK+JPNryuO20tu8l643m4Wppmq3lM4ueQix9/BnNlxth1AYUDgyj
	 B3bSiRnD+UP9tpXH5dNKrNLBYK5ZgOve/0sXIZ0a9Rcgf4u5xCSvxkkGzlfFc1OZG
	 ME8KznRelw+f9p7J6MttJHc/TJUP3fhe9GUuBfgLGLxjrIrwZSR6mIFh3zgnEJgsw
	 VzyNtZJprlv6fu8+OV5FiRoUnbzLhdrO6zBfkQN95N/70+cw43PVbZYIeI+PFi56c
	 bZQeT7DzL/qzQ2Bb1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1qgHGY2vVw-00dxR0; Sun, 31
 Dec 2023 18:40:22 +0100
Message-ID: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
Date: Sun, 31 Dec 2023 18:40:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/4] netlink: Adjustments for __netlink_kernel_create()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2kHjcRU1jatJr3ZHhfmK7Bv2YHs6RMDHFdhs4ty2v/3ww+RWMLH
 7p13feAyZkz6zdT6LKu4OS3tyN3TTlhLFDDA/QLSY92427v2ffRrQdKVt0tpHnlu8l2v4dL
 1BnoGiZ0A9LFvC+EP6f04OEmreqpo4QUgoWfJ/asAkP2k9oxf4Y2EWiPPnklqKhphLN+tek
 BCZQkbpohRT1+/tGJUXZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9i+HhFko9CU=;TCSGrWbdPoZ0wLwyY7HEtukhnGl
 3FIUQT1ds0IzZXWJ91XJhwLQxzO+2sp4zqldGDglo5qxGqk7/uKu0Dim74Bjs/oS9EtXBZCPq
 HhEeyyrCl98v0MOb28fs0wtDR8WRcCKdr+J0m6/XMYNtstGPx6jne1jlEZWJ0qJu81AJbg7AR
 GpzT5lOayBpX61KtzUhvzKV/Eyp/M4ATa1jA+rdtGSfttrr993ldYrNrvHG/dzqJ+pZAn8Dhz
 5qQOPV6CHyWXW4Bj4N7sG/+AHHmPz882Dmhx1E+NESQ8cpRsMNKWc166zsLXo2YwskDCVgaTv
 1IlzEZipEVb5gpSBpL0krDjSh0Nwj9X94TTATzBlg8Hrdkzjp4FpgNrAh+u4ZGoIY2LdzTL5M
 HZKh25ciRXNLsYbRxm3nUHu0PlmMEPaHkFPSvQkPwTqFVe+Nwqbq2H3bfaOoDrsb3V/K8L+E4
 iMkLnIkz8NneqtHgweNtLiqU4SxYJgnv+W5DOE9GKvWK7A/rUPUqY3SiC4eMPDFqfAw3CfVO1
 iGrZyHDXfjXkPD+QfurppniI6dMmsLZTJ/M65ZPonWj2jJcfUpDeGcjat8jjlnikvfoipyA5J
 kzNPnc111PlKUUdFAsKuoZ0X0F7VSOOFrGIFwdHVFVtn5KNQgau769DVS/PlIgS2XaxYUnY+Y
 0jf5KPLov4RMIicd91V7VJ+TjVwJqfzKYqg7F73D9n+GXRPY03vKJ6IKpWdzTwK8Lp3RVVk5M
 UW+wi+TrzVl81WRlceGFcJ0b1se2qdj9XWjIFZhN5VLNhSIEZ6Xkf9JiW6xqyBM3r2caCDK9O
 qY6/U+jMtDOJJmISI4tvwS5AuE+sKZQR1gg6D1acxWxhI0sXtX8OqeRW1mRQVOifxuzop4XJ0
 FK10QNfAqyJ3kkUMr6QOigobq4H0PeOphv6np3KsYhFn887amXubNM3WJKEV3JNoXtpmvAzQ/
 kjy8EA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 18:26:38 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Improve exception handling
  Move an assignment for the variable =E2=80=9Csk=E2=80=9D
  Delete an unnecessary variable initialisation
  Move an assignment for the variable =E2=80=9Ccb_mutex=E2=80=9D

 net/netlink/af_netlink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

=2D-
2.43.0


