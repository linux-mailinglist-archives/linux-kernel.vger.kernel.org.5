Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F897E4C77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbjKGXJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKGXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:09:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1710C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:09:36 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJmDe004891;
        Tue, 7 Nov 2023 23:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=JUrxjybBgVU12dE8uJy/up8iheg95TfqyZBHE6tuEvo=;
 b=MM7cLY0qXudXyX+iaSnYjEt8EbZXxiJ3Ij/7LmOMhxfrnxZQM/pvXfuTZ7HiqDoG3e9N
 2ATOUNmga8sRhLbGAuvyZp3tf6+ONkpY9migG2qtEQ12hzBiM26s+/R80TQhDWmp74/0
 osWxqJovZYoc6NqIPTZnccKNqiENJozWU10fPa5Kmv0cpPhyeFDFb/ulnJXGbaETCmQH
 /O9kp/wHuPw+PUFor9ITUKn29VPOh4j3MK5iyj/7ORxEzRnZJ8rhDWO1zHDjCRYNVmRL
 cZQMXBwEsxN/PYmv0xe65nPFaS2PfagRjge8Cnw8vtZx/LTlE8uJgF3t2pgpMo+gpw+S YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g6a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N1WLX003884;
        Tue, 7 Nov 2023 23:08:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vvb3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfVIZu1ZxRqPPmJka8JPu+PjaATX+nzvW5ufNGx37s8UM8480BbEXyTuklCHdM4QIAKFHM1IQ7GmqLT+M0Ioxg5L9rl4gxWVQoBZK7IUJhQoB5oIpRtPMP3x6rqJxxkmfzSkGRtG95mcrrVCEYRtLQoEB8vAqoS0NSg+aj2ZT30Xwo5PIDh/R4TDTVP3YhNJub5vQMtFxPYqPtftLUtVRJ43xZQxfT+tVcj+mR93K6YxC5kdddMns5pLIxt2R4EG6y8aKC4My0bH8/cyfyd3rgKgh40ZzZoRf+giVu2VpnF+N/IeS4lcu0pI8rPUDayVD7Sys5W6E+R7yF9bHWJP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUrxjybBgVU12dE8uJy/up8iheg95TfqyZBHE6tuEvo=;
 b=NO/F+dMC0YXEnHGlaWA/CmF+gFF7sGfc3rkqQ5Nx5xCRWgpWCFEOO6YwT1EhA5sChj00O3NIPkXQQOZ8vus5lzOP6gpDqyTP8gee3CODaKBtUQDBdVE4y9CKDXysaHiUAnqaqYIUxFUP23jYfyE3m80cjGY7E4hfjfVuW5sjbuNglolIhNzILenQUfVvwSoFIEhQUUYd4u0kgezX7cUPi1Lg1vx4prTpnO2NQ+w9TbgAqe+zNRUgRtJrrosXHQ2il/Hhq9IPxxhsZ/NJQoXOHksqTzGSRjpAFgbBJlSdsseGdxdAP36IqNCvMvaZZQsDGhEJm5v7vTot3f/j4kHEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUrxjybBgVU12dE8uJy/up8iheg95TfqyZBHE6tuEvo=;
 b=olzok2fs1wdZso4IzzSR0NachFT2pnIiEBt8jpihj6wjd7VvB5JL7+fMndfic/0aFW6qXGkd7P/k/MqAHHbXadY9puyaPOqd0KkEDNfb2FsJ/jumoUGLKBzQLVbX6G1KqQ8jCe5a6Ddb3HZsDhrkqEtnC7QFoqQNWEZ3JoxjjeM=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 23:08:27 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:27 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH 58/86] treewide: x86: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:07:54 -0800
Message-Id: <20231107230822.371443-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: bd85f3ef-a060-4da4-9874-08dbdfe6732f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVE+GIgtabS/e6YXdcMc0EUqNuYhpI/ogVyWEe3oziqVnASDECKwJ/KbTrDDrh3FZ6qnZEBzgBgo5OsffvHKFggmzlHLMR8xHW1Mc5n6ysoSVHQukR65+M7y4O7eW0xoDOFPqkCosbvlXl2JeRm2cKave0gBr4uwDziBFz/7ioJfjG077yuBIQSBQBm79QJqrrsjdq3KcqWfX8rjr2DYn8u/m6T1Ro6y6SpXg0MuzpRLEIFIXO1qbSk5n25Q0lRO5I+2e04wdgbNeEDYLc18itCdiaSkqNvtPg1xLSBxe381ESb2kKww0SC3xUkpgFBTbIFQhpJKhjQEMd4J31NT4omxcHSLdvq+2wJLYqMMaKa4ggzFpY7ASY+eioEY+5HAmPFJGcmPV7M6K1oxMWcKdWnyoAd9JMcH4n3e42jNi0u46f1P5YKOvFIVCaOy5ZR7VfZ2ppj4raHovY9lL/CjJp2waJ2pVrgHQzdeDsnpKSgwVJYhygxMJZETFxD8YvPsy1Ht4TjiYnRtUlhq5+w0RzgJ5gIYeuU6XjvEI9hdfBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(7416002)(966005)(7406005)(6486002)(478600001)(6666004)(54906003)(8676002)(316002)(66556008)(6916009)(66946007)(5660300002)(66476007)(4326008)(8936002)(6506007)(66899024)(2616005)(41300700001)(1076003)(26005)(83380400001)(6512007)(38100700002)(103116003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1nhgl7DRdVbL/2M5+fRv5J87ly9CD21OEeirqnBC5RN6InVNh4ioWdUcXpPh?=
 =?us-ascii?Q?10Js7lZy00/kvkp4FrhSJ+vbrOHT+SOV0ANG5AnQqJIVIO/GbFaS6uiR3c2m?=
 =?us-ascii?Q?W0LqNdSTml7832mKUp/tOdr+yGs66/6Rsw1r8YfI2OszKX4hl/AH+HIG3vQN?=
 =?us-ascii?Q?GHx7ferNjjVKPi/smjSFSraHYhiiqsx9QMqGE16nHuLZ64Y+c5cW4UW1n9a8?=
 =?us-ascii?Q?y4TfurtWFDnSzCN6rGTLgD3VEJYZ4DXKHz9brF7LTyVrZO7PLAWkXuxoKlHp?=
 =?us-ascii?Q?3QPahGfTjHHHBJoWti0GqM2LptPe7K5ukCCRyh0pFEfM8kCDnIM4o58C0ZKK?=
 =?us-ascii?Q?/ypvNbNXhJAE63AFitMNqfl8AGDIkLaPfzHr1+mUzZ6+sjMCIRAzulHvDAXL?=
 =?us-ascii?Q?N8dM/uCzfTOAwN8600T78N0hUP/9fIA11jVLKAYlR3VIKSs0XVq8BcfQUJWs?=
 =?us-ascii?Q?9oBaWWmgvSqMVTt411u6ddK/OY/XAW/AdcdsMVnAITq3Rr++OcKlYogmsrPC?=
 =?us-ascii?Q?hIy+lsM9ba6bfkWBZD0fh27RbMiZeYajxnwqXt0CPT1lb57AGFTu1LXseb11?=
 =?us-ascii?Q?llC0gkWrv7WWy2CAMT8QBzJpVCV8exPaxT1bC67k5OlKK9dtFBNKc7aSPzJc?=
 =?us-ascii?Q?tNDYcNNepQTZ6ZrUFrb2ovnJU3lBSuNczizJx3Q0SjRhm0McC00Bkw1WFPI7?=
 =?us-ascii?Q?zz+vdaSf1yQ6AWUO8FV7wdJfXKIEgtYx0a5Kyb0fuUdd90PyAQAKhF6lIhAX?=
 =?us-ascii?Q?jhdmFBEHYnsnujY+ebynTBFoNzEuXZ2fdLtZu/Y4DYXiQ8qt6KHywHinLVjG?=
 =?us-ascii?Q?o55z0mdGimpEDhbKk0RWwbES2lt/xCtJKj76itxd2pe1vtZzPfR5zYuvzPJQ?=
 =?us-ascii?Q?LySDi89jDHkUe2/f8y5AUBFQPIfCZZnMWv5sYq77xA5HQPf13dm8AWBkMopt?=
 =?us-ascii?Q?7QlzJMmAx7wqSzDg3LKAvY4JQUUVDHO8l3tmHQ0cUruHgeur5WLbpaqQFhRO?=
 =?us-ascii?Q?a1CFjjjnE4ryyF4VNABKmcVEOiy/cneF9kq7vPeCF5C/Lx4/MAaoITYB9l9k?=
 =?us-ascii?Q?JPd+wZweGJ1L0ZclELpW/RP/J8b5hnPO5t97Lf8tLBlQbfxFqNzIQW+Aj/pQ?=
 =?us-ascii?Q?2c9ksb6pjGkQvEb2dTO63uOc4ykq1a6TihqJPfAulzHl1eiCMF8LfGCNNUbO?=
 =?us-ascii?Q?nxqT6cOSUYkzN43ZWGMrtZWLQJC4xC/PDlp+7Li3gZv2Cwjzj7fcCHp4XKL8?=
 =?us-ascii?Q?ji7gcG3fQP3sg42OVaA3ey2zWThptIxq7P8XXo+5g8uzA1/AGqRCEhqoePNv?=
 =?us-ascii?Q?sU75BSHvg559Qgh6DLR5wdTKKYVfxYsT0ze1KyTwQ0rsoc6J7QOH+jKVGGP9?=
 =?us-ascii?Q?UeaqdNsdQKSTxm2pBNTWdCcphsZl8Ra3JLxBOAqWSOPJZ/kBuQJfSkTvt9f/?=
 =?us-ascii?Q?/MRtBTRU4aS3mjKsI5JsE8l7n0wmwOX/t1GXEAd/XNDiy0VVxhoD2oHbPKi9?=
 =?us-ascii?Q?Uko64MneQT3Z+P4zdHFIAjaWTfU0wWkklRBZEUcxicAAa5WPr4p12Yw/rThl?=
 =?us-ascii?Q?W0/XIWPtHwoWqexW/h+FGU1MMI0R8AxaqdauczHBkEXlGXmBscDvShL2DXi8?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZTtIpliEN/9Bg0eqMho7z/TljHpX12usdo3F6IHKj74NCMOWWKav0Ruoy+/c?=
 =?us-ascii?Q?X/dMPOsNOmzJ/ndxF3RqypcAlR0yf0e1TI6KncOwyUloKAc9NyNop+hYNcA3?=
 =?us-ascii?Q?2t1u1YV8wd7hss9z+Nlkc4xy7bYv795YXSZ9ppxVHVyuDeUrVE0aKYdmzA+j?=
 =?us-ascii?Q?bTvb1p9xaECupabFaCaMw4DWPD95hJdwr/1/u1Bkye+pvP7YaFYDVrtEws6l?=
 =?us-ascii?Q?skxkIlpL4wQwi5RhcP0AClGDKsnAihxVdv4spxF33Dm0d78ufAAmm3s8zVqM?=
 =?us-ascii?Q?rSEc+dOIPM++/9sW4PUYFJUnB/ouTLDAutK0J+vitBWlHRD3g65Mwzhi4BDd?=
 =?us-ascii?Q?S1YGD6Jgpu8x9On/5l3FhPayzlYpsZRP+RoHE4QxGHBZ0qUzLwjr2GYLJs6Q?=
 =?us-ascii?Q?43iodPDczEAFOo4grXdBvAGXLEvUwBOxR7emu2PQ2Q6OTfyanS/LAqqkH4Va?=
 =?us-ascii?Q?XPBxVlnk+CqX73lmaPO9/CD7giYAcuooBZPY7x7y8Mx9DrnRLVTdLljNk1lM?=
 =?us-ascii?Q?G61252LThcO1GzlhPuTls2qjYGiNZGNCtoq25Xz1PKMdn0zWjwhuSCDnqrGb?=
 =?us-ascii?Q?x9VW4whPOzKPLn2ZkozlBUH/0VGyTwNptQ1oNuePiz/keKaqsSnUN2OY8mFc?=
 =?us-ascii?Q?9p5HPU1wKBJq0UC5KZ4Gx5JBKSgQw6lv3AP8KY7yZyvwBG0f987oHpyglTVs?=
 =?us-ascii?Q?//2m8QiVImK7p7agml7xZCwqNbzmhoZrm7AEuZoNYsQA8gVpDKKcNDAJaHNx?=
 =?us-ascii?Q?7Sq+FQUq/IYrvDx2rj/NcVJMucUnWKn4YtTE52l4D2LSVgx7X/yGDEgfpGms?=
 =?us-ascii?Q?VIaOANvMsVf7R8U/mU/fPFkEss8bPu0sYDF/yFIm0tZnb9pWJ8YJ8qcRN7UF?=
 =?us-ascii?Q?Mr8oDDdQjPNLGhu/jt/71UQpwxdCEzCEoXhjD1py/XzX2as6yrbjxVyCjh11?=
 =?us-ascii?Q?v5kdIpMB8cFqHBgp/NdDzz1WPGX4cCAnnMsFSCtVSUIDC4Wf+QbN3IlSV/bZ?=
 =?us-ascii?Q?yamfGMrGzYF/jtizaSHy5PHtkuiK2Ep5rNNhz9qR1/nSLrR177/S5Pz4jmSf?=
 =?us-ascii?Q?cQFnNuBDQB3vT9aisMVpjRS7+bxWGtISWcvXZ2nlAydRTC+fgyiytUOlvu81?=
 =?us-ascii?Q?UJHRmCdQvHVy/7+L3NdE+hLi+zm6Pnlo68+UKKDDAVjMjw9IYD5d8qLNDvGC?=
 =?us-ascii?Q?heSV0WwH01m3mWGiX022s6rhb2XbcWfAJvxnfPNz9IUezZYHV2m/9BamN93i?=
 =?us-ascii?Q?UWmnzvCENeA02Z6dUJmohvcmGXgFhbNItOuJgAddr49sJ9g9at0hkWKxlN2S?=
 =?us-ascii?Q?ZKZSVz2d8aDRspPjfu9KYCqcT3zk+Ti+oTvB6C8V3TzMd/BcBBrmwd7JMzsl?=
 =?us-ascii?Q?pq7aIwDCF88Qe6CkEPeM3w2yfPSOdqGdRxqfsJl5S+WAxwyqrOVoNHuDWq5V?=
 =?us-ascii?Q?wYj3D4JJuCK5rq1v7z7cKX31nmkqefAL44G1uuwt2fNAwrHP1doW2N9MwWHT?=
 =?us-ascii?Q?PaE+co4mCUoHcC9t3JYk4WejyaE2g4JFKvo0ZNVfqDZD+KsF73/lwV6PyKSf?=
 =?us-ascii?Q?4xCJZoNHf8xEgJdmaw+DIBPo/guE9eOHJCCPwYrveRhU6xGRqIVKYdYzz3Km?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd85f3ef-a060-4da4-9874-08dbdfe6732f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:27.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICN7qkWBnYK75rBCsGktgNqf5nLM87nqhT5MCe83jFQehohiOMFfWAZdz8n30OIUcNPguYyujwCM48j05z4ulqSeSnrp91Q25vRoIfMbhV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: CqRb7WlE4XBNB7B3No97MJCXCVInoxjb
X-Proofpoint-GUID: CqRb7WlE4XBNB7B3No97MJCXCVInoxjb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well
be -- for most workloads the scheduler does not have an interminable
supply of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

Most of the instances of cond_resched() here are from set-1 or set-2.
Remove them.

There's one set-3 case where kvm_recalculate_apic_map() sees an
unexpected APIC-id, where we now use cond_resched_stall() to delay
the retry.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Borislav Petkov <bp@alien8.de> 
Cc: Dave Hansen <dave.hansen@linux.intel.com> 
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com> 
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: David Ahern <dsahern@kernel.org> 
Cc: x86@kernel.org 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/alternative.c   | 10 ----------
 arch/x86/kernel/cpu/sgx/encl.c  | 14 +++++++-------
 arch/x86/kernel/cpu/sgx/ioctl.c |  3 ---
 arch/x86/kernel/cpu/sgx/main.c  |  5 -----
 arch/x86/kernel/cpu/sgx/virt.c  |  4 ----
 arch/x86/kvm/lapic.c            |  6 +++++-
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/svm/sev.c          |  5 +++--
 arch/x86/net/bpf_jit_comp.c     |  1 -
 arch/x86/net/bpf_jit_comp32.c   |  1 -
 arch/x86/xen/mmu_pv.c           |  1 -
 11 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be3931e4f0..3d0b6a606852 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2189,16 +2189,6 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 */
 	atomic_set_release(&bp_desc.refs, 1);
 
-	/*
-	 * Function tracing can enable thousands of places that need to be
-	 * updated. This can take quite some time, and with full kernel debugging
-	 * enabled, this could cause the softlockup watchdog to trigger.
-	 * This function gets called every 256 entries added to be patched.
-	 * Call cond_resched() here to make sure that other tasks can get scheduled
-	 * while processing all the functions being patched.
-	 */
-	cond_resched();
-
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
 	 * nr_entries and handler are correctly ordered wrt. patching.
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..05afb4e2f552 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -549,14 +549,15 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 			break;
 		}
 
-		/* Reschedule on every XA_CHECK_SCHED iteration. */
+		/*
+		 * Drop the lock every XA_CHECK_SCHED iteration so the
+		 * scheduler can preempt if needed.
+		 */
 		if (!(++count % XA_CHECK_SCHED)) {
 			xas_pause(&xas);
 			xas_unlock(&xas);
 			mutex_unlock(&encl->lock);
 
-			cond_resched();
-
 			mutex_lock(&encl->lock);
 			xas_lock(&xas);
 		}
@@ -723,16 +724,15 @@ void sgx_encl_release(struct kref *ref)
 		}
 
 		kfree(entry);
+
 		/*
-		 * Invoke scheduler on every XA_CHECK_SCHED iteration
-		 * to prevent soft lockups.
+		 * Drop the lock every XA_CHECK_SCHED iteration so the
+		 * scheduler can preempt if needed.
 		 */
 		if (!(++count % XA_CHECK_SCHED)) {
 			xas_pause(&xas);
 			xas_unlock(&xas);
 
-			cond_resched();
-
 			xas_lock(&xas);
 		}
 	}
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d390df21440..2b899569bb60 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -439,9 +439,6 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 			break;
 		}
 
-		if (need_resched())
-			cond_resched();
-
 		ret = sgx_encl_add_page(encl, add_arg.src + c, add_arg.offset + c,
 					&secinfo, add_arg.flags);
 		if (ret)
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 166692f2d501..f8bd01e56b72 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -98,8 +98,6 @@ static unsigned long __sgx_sanitize_pages(struct list_head *dirty_page_list)
 			list_move_tail(&page->list, &dirty);
 			left_dirty++;
 		}
-
-		cond_resched();
 	}
 
 	list_splice(&dirty, dirty_page_list);
@@ -413,8 +411,6 @@ static int ksgxd(void *p)
 
 		if (sgx_should_reclaim(SGX_NR_HIGH_PAGES))
 			sgx_reclaim_pages();
-
-		cond_resched();
 	}
 
 	return 0;
@@ -581,7 +577,6 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		}
 
 		sgx_reclaim_pages();
-		cond_resched();
 	}
 
 	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 7aaa3652e31d..6ce0983c6249 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -175,7 +175,6 @@ static long sgx_vepc_remove_all(struct sgx_vepc *vepc)
 				return -EBUSY;
 			}
 		}
-		cond_resched();
 	}
 
 	/*
@@ -204,7 +203,6 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			continue;
 
 		xa_erase(&vepc->page_array, index);
-		cond_resched();
 	}
 
 	/*
@@ -223,7 +221,6 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			list_add_tail(&epc_page->list, &secs_pages);
 
 		xa_erase(&vepc->page_array, index);
-		cond_resched();
 	}
 
 	/*
@@ -245,7 +242,6 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 
 		if (sgx_vepc_free_page(epc_page))
 			list_add_tail(&epc_page->list, &secs_pages);
-		cond_resched();
 	}
 
 	if (!list_empty(&secs_pages))
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3e977dbbf993..dd87a8214c80 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -435,7 +435,11 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 			kvfree(new);
 			new = NULL;
 			if (r == -E2BIG) {
-				cond_resched();
+				/*
+				 * A vCPU was just added or a enabled its APIC.
+				 * Give things time to settle before retrying.
+				 */
+				cond_resched_stall();
 				goto retry;
 			}
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f7901cb4d2fa..58efaca73dd4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6431,8 +6431,8 @@ static int shadow_mmu_try_split_huge_page(struct kvm *kvm,
 	}
 
 	if (need_topup_split_caches_or_resched(kvm)) {
+		/* The preemption point in write_unlock() reschedules if needed. */
 		write_unlock(&kvm->mmu_lock);
-		cond_resched();
 		/*
 		 * If the topup succeeds, return -EAGAIN to indicate that the
 		 * rmap iterator should be restarted because the MMU lock was
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4900c078045a..a98f29692a29 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -476,7 +476,6 @@ static void sev_clflush_pages(struct page *pages[], unsigned long npages)
 		page_virtual = kmap_local_page(pages[i]);
 		clflush_cache_range(page_virtual, PAGE_SIZE);
 		kunmap_local(page_virtual);
-		cond_resched();
 	}
 }
 
@@ -2157,12 +2156,14 @@ void sev_vm_destroy(struct kvm *kvm)
 	/*
 	 * if userspace was terminated before unregistering the memory regions
 	 * then lets unpin all the registered memory.
+	 *
+	 * This might be a while but we are preemptible so the scheduler can
+	 * always preempt if needed.
 	 */
 	if (!list_empty(head)) {
 		list_for_each_safe(pos, q, head) {
 			__unregister_enc_region_locked(kvm,
 				list_entry(pos, struct enc_region, list));
-			cond_resched();
 		}
 	}
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a5930042139d..bae5b39810bb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2819,7 +2819,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			prog->aux->extable = (void *) image + roundup(proglen, align);
 		}
 		oldproglen = proglen;
-		cond_resched();
 	}
 
 	if (bpf_jit_enable > 1)
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..03566f031b23 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2594,7 +2594,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			}
 		}
 		oldproglen = proglen;
-		cond_resched();
 	}
 
 	if (bpf_jit_enable > 1)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b6830554ff69..a046cde342b1 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2510,7 +2510,6 @@ int xen_remap_pfn(struct vm_area_struct *vma, unsigned long addr,
 		addr += range;
 		if (err_ptr)
 			err_ptr += batch;
-		cond_resched();
 	}
 out:
 
-- 
2.31.1

