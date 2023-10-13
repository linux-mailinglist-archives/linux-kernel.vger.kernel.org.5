Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258847C7D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjJMGFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJMGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:05:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003DAB7;
        Thu, 12 Oct 2023 23:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDXhxyYWAm/NACYl+WofDkHWH61tGmBMARsJipIU46kxUVjlcIzpcCshvYFk9h0rLZXhYMRFMXhf19DcfrqWishJta5ovTuJXdDTVr6DnwCISm7gs4p3RCW8INvMW7wwA18qfh7BV+h3vaTbMuNayz5q98+FwT/SBbTOSrRkmBFssNCdgY7d1vgfmPEPIcEsvLRGcFiv/TLHNQHCFC2nBUcjAMdWgidoPo3jhO9DFqa0G40MkHkLRTaYH6fEl673f1+hqvpbgvldHZL+lgDCCHrl+8KXFOG0RhC4ervVzgZJwMAoA5W5Isrzj3AeQcAXZT7oSCazIWRPzicRihDfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzJ4Jnp9VHKbaU4dCGfSPaWDrGzwF+Y9FkoSI40ifyI=;
 b=H6VohG4aBvERDHV6S+sHK+CU5mF8Byl6Qyg4+UIdLoqbk9FeQrI0D1j080NmTEfbcavsp9GjlzAzQ9/Y/Jtm9ueH9XeiA4oiJ5RZbGgHnKXK5a6WnyJoy/uF2fQ+szAXjZK+8jIPxrXWqP65OnJvowNG+rS+MSvIQuHsWuOX7iWvSBQAy7fJ17+x2e+2yRFAP7Zy1c0w5mzP1Emw2JfniEWUH2bV6Pgj68Sv8fQQiCyt+GTLFmykKvzyTnU314ucm9Jftv07IAJ6kTg+S58xKoYRJgcbDdvNAPW9yEQVQecuz7oqz2F7djeD+AS9dXHHmMO9aLkB6/JQdFvpiDDB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=renesas.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzJ4Jnp9VHKbaU4dCGfSPaWDrGzwF+Y9FkoSI40ifyI=;
 b=GXkC2+tSTwMmM/eDNkBpX0qbWouIBf872VXkIfbIdOMVS+yALDqOxeVoo1MdtPDV8yeLZkU6XdNCb3h2lb/+OvKGUGJmqNKegpn6MBX29t+CksLGAtOpcOlN3k71EYwFFgZdvBd+vgq8cM07ZyPHaEOAYfjbAYVINUoNEVGkKAo58HjGOt2tLvPXWq7WCIfNC9x74XmS4mIbKsjDWP1f/fT4ZgFjlppoLlRVvqUYWEWe+SZdP/X3UbL+TOXzuVANisAtGkDN/M2psYXTbvU3kXrTnQ3mfhslY2SvadgWSRszPu36E5BaJwAL9/ldGO3U+w4WQ6+yxoMkB+0Lvm5ltQ==
Received: from AS8P189CA0015.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::11)
 by DB9PR10MB5259.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Fri, 13 Oct
 2023 06:04:57 +0000
Received: from AM7EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::c4) by AS8P189CA0015.outlook.office365.com
 (2603:10a6:20b:31f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 06:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 AM7EUR03FT015.mail.protection.outlook.com (100.127.140.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.15 via Frontend Transport; Fri, 13 Oct 2023 06:04:57 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 13 Oct
 2023 08:04:53 +0200
Received: from [10.34.222.178] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 13 Oct
 2023 08:04:53 +0200
Message-ID: <93811ef2-8df9-de21-3f8d-296400ec2ba5@de.bosch.com>
Date:   Fri, 13 Oct 2023 08:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: RE: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Content-Language: en-US
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "lee@kernel.org" <lee@kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        Zheng Wang <zyytlz.wz@163.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <de4ab49b-f1a7-5732-0970-13fd03407376@de.bosch.com>
 <TYBPR01MB5341D3791E728E3D9EFC25D4D8D3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
In-Reply-To: <TYBPR01MB5341D3791E728E3D9EFC25D4D8D3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.139.217.196]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT015:EE_|DB9PR10MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 015c53a9-0adf-4230-9527-08dbcbb253c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfDgW3svydflcCj5m1JSlbu+CAiS9njrOFJeBSAVug/wVD6YJlQW3PWsAVbkgwYDYncwofqIjk1tQTXNBgaL4WFleB75qSskfmBCqK7870RN6yRic76ae0+bxUtINPO/NUAFqVruDoCurXihhwDsLePiyPNjfKzS8MSG/UmfCwmbVmgrUhuOuWC3OddlHTmnseVW7pBlLmmMfsVW/febRiIqyEkgJPpNKvaVaJ98CFRgt/vsDCshvhiVMrMtQsgl3yPe0VPWwXi15VlWuDI2DpF2JWyzyzs7L3zonq95Gj3xzWXteZhJUT3U6V8vF79c7Eg1G6yWgjXVELHbUwQlbhO4jAp9C7C7yK5XEjgdJ+bs2t8n9HzwwQP8SvtqhU5ElnUAsqaA3ugEMURKATtos2VUSj+WBtKahdhnHy7ecSGGx4nUD+ydyggo/Qsw8QTmwPLCnD/m4bn8CBWk9khJaZBdyWjJ0wClgMTjNCngJUC1qloNbfepCrZgTTHzeJUEHjVooxcYJcy7hFDUmxg96Qd2ZZDyIFnGy6hjyK5tnlyh1ExfoOUY1mE3a4QexaFuzEoGvCvEE+Z6loOnBAqdfnQJ1ciFnJpdMGL5yDu2JYCfLxLH4UjpF0XMwf0Fm6j1qIu6OS5fOdpJmUCtKMIwelItIEqYg1IQKQqaDWDHqyk60eo/y7QISJTB3PdAiFCYrBSWg4xIz0uxTizDRk9kBdYf07FlY6QOSavMe7FG5zhh+uNVUgwiShGDkZWZ3S8m2h+9eswjIly2XWaqM3/1KxrEtVqrnYmT9SOSyGtEtCw=
X-Forefront-Antispam-Report: CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(54906003)(8936002)(70586007)(4326008)(5660300002)(8676002)(70206006)(316002)(16576012)(6916009)(7416002)(41300700001)(31686004)(966005)(40460700003)(2906002)(336012)(26005)(83380400001)(356005)(81166007)(82740400003)(82960400001)(47076005)(40480700001)(36860700001)(2616005)(53546011)(31696002)(86362001)(426003)(66574015)(45080400002)(16526019)(6666004)(478600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 06:04:57.2154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015c53a9-0adf-4230-9527-08dbcbb253c2
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5259
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.10.2023 10:39, Yoshihiro Shimoda wrote:
> Hello Behme,
> 
>> From: Behme Dirk (CM/ESO2), Sent: Tuesday, October 10, 2023 9:59 PM
>>
>> On 26.07.2023 05:19, Jakub Kicinski wrote:
>> ...
>>> The fact that ravb_tx_timeout_work doesn't take any locks seems much
>>> more suspicious.
>> Does anybody plan to look into this, too?
> 
> I believe my fixed patch [1] resolved this issue too. 


I'm not an expert of this driver nor the network stack, so sorry if I'm 
totally wrong here ;) But somehow this answer confuses me. Let me explain:

What you did with [1] is to stop/cancel the workqueue in ravb_close(). 
That's fine. But that is at driver's close time.

What's about driver's normal runtime? What I understood is that 
ravb_tx_timeout_work() might run totally asynchronously to the rest of 
the driver. And therefore needs locking/protection/synchronization if it 
uses resources of the driver which are used elsewhere in the driver, too.

I think this is exactly what is described with:

> ---
> Simplest fix I can think of is to take a reference on the netdev before
> scheduling the work, and then check if it's still registered in the work
> itself. Wrap the timeout work in rtnl_lock() to avoid any races there.
> ---

So, where is above done? Not at close time, but at normal run time of 
the driver?

Best regards

Dirk

> Sergey suggested to add cancel_work_sync() into the ravb_close () [3].
> And I investigated calltrace, and then the ravb_close() is under rtnl_lock() [4]
> like below:
> -----------------------------------------------------------------------
> ravb_remove() calls unregister_netdev().
>   -> unregister_netdev() calls rtnl_lock() and unregister_netdevice().
>   --> unregiter_netdevice_queue()
>   ---> unregiter_netdevice_many()
>   ----> unregiter_netdevice_many_notify().
>   -----> dev_close_many()
>   ------> __dev_close_many()
>   -------> ops->ndo_stop()
> 
> ravb_close() calls phy_stop()
>   -> phy_state_machine() with PHY_HALTED
>   --> phy_link_down()
>   ---> phy_link_change()
>   ----> netif_carrier_off()
> -----------------------------------------------------------------------
> 
> So, during cancel_work_sync() is waiting for canceling the workqueue in ravb_close(),
> it's under rtnl_lock() so that no additional locks are needed in ravb_tx_timeout_work().
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=3971442870713de527684398416970cf025b4f89
> [2] https://lore.kernel.org/netdev/20230727164820.48c9e685@kernel.org/
> [3] https://lore.kernel.org/netdev/607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru/
> [4] https://lore.kernel.org/netdev/OSYPR01MB53341CFDBB49A3BA41A6752CD8F9A@OSYPR01MB5334.jpnprd01.prod.outlook.com/
> 
> Best regards,
> Yoshihiro Shimoda
> 
>> Best regards
>>
>> Dirk

-- 
======================================================================
Dirk Behme                      Robert Bosch Car Multimedia GmbH
                                 CM/ESO2
Phone: +49 5121 49-3274         Dirk Behme
Fax:   +49 711 811 5053274      PO Box 77 77 77
mailto:dirk.behme@de.bosch.com  D-31132 Hildesheim - Germany

Bosch Group, Car Multimedia (CM)
              Engineering SW Operating Systems 2 (ESO2)

Robert Bosch Car Multimedia GmbH - Ein Unternehmen der Bosch Gruppe
Sitz: Hildesheim
Registergericht: Amtsgericht Hildesheim HRB 201334
Aufsichtsratsvorsitzender: Dr. Dirk Hoheisel
Geschäftsführung: Dr. Steffen Berns;
                   Dr. Sven Ost, Jörg Pollak, Dr. Walter Schirm
======================================================================

