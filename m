Return-Path: <linux-kernel+bounces-34669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8788385EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC94287994
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B361848;
	Tue, 23 Jan 2024 03:08:45 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9A810;
	Tue, 23 Jan 2024 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705979324; cv=none; b=lVzpUm/PbZdcsll3NmNyuVC3g/ImiqYtWfshBD0v1vwW3Thq+j/aOxZEr9puZsTKA47LYErio0iBXeuz2qrhKpvbtC7ozjhJ1IFDwmsFiQ+M53zA5+YPkTgJskwpXt0QY/HS+EC4B3ci07RxRPEBsZ2hfrAb27i0LXFqalmbjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705979324; c=relaxed/simple;
	bh=nSI4BAqP3x9fASt6i5uBdW1dhisjPKtWVX5mFYjrAB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJe93iYAKn8zkf6yxuMEDoAaFFHWLsZTV8ucbPQz3wwo6IjB8msxstjiqwgb/IXS9pCVyzmmhA3F/AaadXzjN8LntpZPi+UG5+UOpbGNovrCKu3Om5wlSC0fXOjDYLTqkt7X1jxneR97Ks0clG+V4Pk3Umz2mCFhDe+YRBbq5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJsSb1Wnqz29kf6;
	Tue, 23 Jan 2024 11:06:55 +0800 (CST)
Received: from dggpemd500003.china.huawei.com (unknown [7.185.36.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B1EE1406C8;
	Tue, 23 Jan 2024 11:08:23 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpemd500003.china.huawei.com (7.185.36.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 23 Jan 2024 11:08:22 +0800
From: gaoxingwang <gaoxingwang1@huawei.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <gaoxingwang1@huawei.com>,
	<liaichun@huawei.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <yanan@huawei.com>,
	<yoshfuji@linux-ipv6.org>
Subject: Re: [Discuss]iproute2: ipv6 route add fail
Date: Tue, 23 Jan 2024 11:08:13 +0800
Message-ID: <20240123030813.2493801-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CANn89iK05tppo0neGmKTdU-Dp8Dap6ayxda-++Z3LRp3DFrq+w@mail.gmail.com>
References: <CANn89iK05tppo0neGmKTdU-Dp8Dap6ayxda-++Z3LRp3DFrq+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd500003.china.huawei.com (7.185.36.29)

>> Hello everyone,
>>
>> Here is a particular problem with routing.
>> Sometimes users can run the ip -6 route command to add a route whose destination address is the same as the gateway address, and it can be successfully added. However, adding another route with the same gateway address will fail later.
>>
>> Example:
>> # ip -6 route add 2409:8080:5a0a:60c7::7/128 via 2409:8080:5a0a:60c7::7 dev eth2
>> # ip -6 route add 2409:8080:5a0a:60c7::8/128 via 2409:8080:5a0a:60c7::7 dev eth2
>> RTNETLINK answers: No route to host
>>
>> Does the kernel not support this application scenario?
>> Or should the kernel not allow routes with the same destination address as the gateway address to be added so that other more meaningful routes can be added successfully?
>>
>> This question puzzles me, thank you very much if your can reply.
>
>try running `perf record -e fib6:*` and then run both route commands
>above. After both have run, Ctrl-C on perf and then run `perf script`

Here is the result:
  swapper     0 [002]  5247.545507: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe58:e86e/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5247.545511: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe58:e86e/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.545549: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe58:e86e/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.545554: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe58:e86e/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.545562: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 fe80::5054:ff:fe58:e86e/0 -> ff02::2/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
       ip 59595 [001]  5247.593130: fib6:fib6_table_lookup: table 254 oif 4 iif 0 proto 0 ::/0 -> 2409:8080:5a0a:60c7::7/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
     bash 59600 [002]  5247.598824: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 58 fe80::5054:ff:feb7:19af/0 -> ff02::1:ffb7:19af/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.598824: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 fe80::5054:ff:feb7:19af/0 -> ff02::1:ffb7:19af/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.636429: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.636465: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.641108: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe93:d0db/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5247.641112: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe93:d0db/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.641118: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe93:d0db/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.641128: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe93:d0db/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.641134: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 17 fe80::5054:ff:fe93:d0db/0 -> ff02::fb/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.642525: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe37:e95a/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.642532: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe37:e95a/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.642537: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 17 fe80::5054:ff:fe37:e95a/0 -> ff02::fb/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.642549: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe37:e95a/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5247.642552: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe37:e95a/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.689676: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe09:14e5/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5247.689680: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe09:14e5/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5247.689682: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe09:14e5/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.689684: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:fe09:14e5/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.689690: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 fe80::5054:ff:fe09:14e5/0 -> ff02::2/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.716616: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.716616: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.716845: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 ::/0 -> ff02::1:ff0f:9a04/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.716907: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 58 ::/0 -> ff02::1:ff0f:9a04/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.778211: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 ::/0 -> ff02::1:ff05:7/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.778243: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 58 ::/0 -> ff02::1:ff05:7/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.823813: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:feba:b2fc/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5247.823816: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:feba:b2fc/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.823818: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:feba:b2fc/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.823821: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 58 ff02::2/0 -> fe80::5054:ff:feba:b2fc/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5247.823824: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 fe80::5054:ff:feba:b2fc/0 -> ff02::2/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.867777: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.867820: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [002]  5247.958396: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.958431: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.959463: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.959503: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.960377: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.960442: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.961515: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.961525: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [002]  5247.962557: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.962557: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5247.963515: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.963524: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5247.965165: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5247.965178: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 0 ::/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [002]  5248.014889: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 58 fe80::5054:ff:fe8f:5578/0 -> ff02::1:ff35:6cd7/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5248.014890: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 fe80::5054:ff:fe8f:5578/0 -> ff02::1:ff35:6cd7/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
       ip 59608 [002]  5248.054418: fib6:fib6_table_lookup: table 254 oif 4 iif 0 proto 0 ::/0 -> 2409:8080:5a0a:60c7::7/0 tos 0 scope 0 flags 0 ==> dev eth2 gw 2409:8080:5a0a:60c7::7 err 0
       ip 59608 [002]  5248.054422: fib6:fib6_table_lookup: table 255 oif 4 iif 0 proto 0 ::/0 -> 2409:8080:5a0a:60c7::7/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
       ip 59608 [002]  5248.054423: fib6:fib6_table_lookup: table 254 oif 4 iif 0 proto 0 ::/0 -> 2409:8080:5a0a:60c7::7/0 tos 0 scope 0 flags 0 ==> dev eth2 gw 2409:8080:5a0a:60c7::7 err 0
  swapper     0 [001]  5248.083555: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 fe80::5054:ff:fec6:b788/0 -> ff02::1:ffc6:b788/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5248.083555: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 58 fe80::5054:ff:fec6:b788/0 -> ff02::1:ffc6:b788/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5248.102781: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 58 ff02::16/0 -> fe80::5054:ff:fed0:af21/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5248.102788: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 58 ff02::16/0 -> fe80::5054:ff:fed0:af21/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5248.102793: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 0 fe80::5054:ff:fed0:af21/0 -> ff02::16/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5248.102801: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 58 ff02::16/0 -> fe80::5054:ff:fed0:af21/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5248.102805: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 58 ff02::16/0 -> fe80::5054:ff:fed0:af21/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5248.119317: fib6:fib6_table_lookup: table 255 oif 0 iif 3 proto 58 33:33::fe:1b2b/0 -> ff02::1:ff07:3b36/0 tos 0 scope 0 flags 0 ==> dev eth1 gw :: err 0
  swapper     0 [001]  5248.119424: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 58 33:33::fe:1b2b/0 -> ff02::1:ff07:3b36/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5248.140988: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:feea:2acb/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5248.140994: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:feea:2acb/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [001]  5248.140999: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 17 fe80::5054:ff:feea:2acb/0 -> ff02::fb/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5248.141018: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:feea:2acb/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [002]  5248.141021: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:feea:2acb/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5248.141998: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe19:9964/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5248.142003: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe19:9964/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5248.142006: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe19:9964/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5248.142006: fib6:fib6_table_lookup: table 255 oif 0 iif 4 proto 17 fe80::5054:ff:fe19:9964/0 -> ff02::fb/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0
  swapper     0 [002]  5248.142009: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 17 ff02::fb/0 -> fe80::5054:ff:fe19:9964/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
systemctl 59624 [002]  5248.165214: fib6:fib6_table_lookup: table 255 oif 3 iif 1 proto 58 ff02::16/0 -> fe80::6390:1eeb:fded:e180/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5248.165214: fib6:fib6_table_lookup: table 255 oif 4 iif 1 proto 58 ff02::16/0 -> fe80::6390:1eeb:fded:e180/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
systemctl 59624 [002]  5248.165217: fib6:fib6_table_lookup: table 254 oif 3 iif 1 proto 58 ff02::16/0 -> fe80::6390:1eeb:fded:e180/0 tos 0 scope 0 flags 0 ==> dev lo gw :: err -113
  swapper     0 [001]  5248.165219: fib6:fib6_table_lookup: table 254 oif 4 iif 1 proto 58 ff02::16/0 -> fe80::6390:1eeb:fded:e180/0 tos 0 scope 0 flags 0 ==> dev eth2 gw :: err 0

