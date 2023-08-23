Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE371785F08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbjHWR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbjHWR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:59:30 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6310C7;
        Wed, 23 Aug 2023 10:59:28 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NGjbgv016846;
        Wed, 23 Aug 2023 10:59:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=RuWoLXB+y8l63Howb3tcLuC6vLKrOlQKHd9tpn2g7ck=;
 b=uLhOxykWaJ2veH3d1RLZT9Uf16z3zn6xLthpbImpza37xp1vJviiDOJ+l1Ec1YVQ+CLO
 8obFix85vmQiEQq6knkctCws27CpFkERL1usSazva4EyGNn2cQ0IaNpD1DllqezuAxZ0
 G6BGvehd3GP9dTy8FXUMt23nFEexLYdBs1nwzitW7VewignuhjfRgF6bpm+ojliHtFi8
 /GVeuO89GH/5FyVyeca3iOiuLwmsNKMqs9aUC71xvt3LyH8iwMgACBuGH5mCYQnzQaU9
 DcoFfyaPKn4lJkCLktkeQWQFT7v1p+7lcidQEr79NNxPA5KsiMfTkSO1PgeiPCJcIqWl ow== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sn21qe46v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:59:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692813560; bh=RuWoLXB+y8l63Howb3tcLuC6vLKrOlQKHd9tpn2g7ck=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=l4pumRZmhSWteKrK7cXBOQ3X7H9FJMRINfJ7IhC/inBH1ZtT72CNDMQUQFSWbQbgM
         2WKXlNDBIkEPfW/V48vVA7YkzRiSY8dUA4FUbD9H17yn3+kgLdeAe3lo9NmHRz+Pds
         is2MnII9Mbv2YAhBoYMvqdd9wUDb902HtPRGWhHByPedGcu7GhKzTtfgvcNdG6ZXac
         dmrTFWCovK4dgeh2w1nOTW3+x73Ya2Yo+u0mHAkZzdVIL4CcflukOdkcfWG/FwFvCF
         657S1OfVNTYeRjPBP1tqWCpZFJS6hn+vzzVlhIvDarOO/LuTaB3pfUGTTrB5ANbTLG
         31NjVyXuhSfKg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 06A6940520;
        Wed, 23 Aug 2023 17:59:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id B8019A0080;
        Wed, 23 Aug 2023 17:59:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uYJc1yNd;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E6125404AC;
        Wed, 23 Aug 2023 17:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS+iwQVg/SRh5lizq6Tp7byAwA11AoBB99pS2agNnA5UCiomdZyIS6RHKzGY8n5vji9blPxXqlkXNSroG6gySGkgWchL/bdi8SC10fsM3Bqw41HPFUpLFp7CvO6eE88DBJO66AbA+TswBhHGUqUr5da1k9Yz4pHPAD7MXwa7YWfAZPNdyrJWs5FRBvUhGd1iY89LxIfdXIdapKZadnWDg0G6CzXvziwGg+N1UnqJdQPGJbl/6iti6RG7f1HDxR1O9pR1zLyJCHM366X4xpqtjPP+dNR14/ZzxKtjpEsSxyr2dpZZOlSwi2APlmD7p/q3Arj+czDg/vegI1510g0DbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuWoLXB+y8l63Howb3tcLuC6vLKrOlQKHd9tpn2g7ck=;
 b=IZs098RplEezKcZfdwrHSWIUMLi1cjnA74QBOzzllYROTugWP2S/TlewvTIk+3qJEakAfVGGrzzaQtWC8/6FZ0+RYb0ZdpgIIpASbUk1jEkFKFkw3gh7Z2LV+3X2AugFCIX1s0Q0UoOYH3ICHPOc11lrQT+SXDdTZnDzAEe9dLylYXQHxBm2zIfyOeNOQ3tj/w2/aeUZLKuEZfj4kWk7MC+AKLxExAgio+joA9Rj4TH0QwsHQEArx5jlVKcSFYZFNgyi7dXpZZ5exAmahCyy0wroOMRu7g+5jAAuNZD2qCRrGGIMM1N4Y5MmLsxrchJEyzTGpE2QVQREkF6JaWoQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuWoLXB+y8l63Howb3tcLuC6vLKrOlQKHd9tpn2g7ck=;
 b=uYJc1yNdVRxvMETPZbxQq5GVNyrFiCI379WdAttGnvqcYyBmAkCEpsg7dX9OU2mbyb7pWm2d1eaZrQLTYxNHUdLdLluhoPcK2dj2qrzUSqrTQ4F7JZlRvOmaY68BJr68VXIH8nQzCRTRihzvA+2zZLs2wRAj/17qlqImM8vhSFk=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 17:59:07 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 17:59:07 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAA+wcgIAA2rMAgAAtNoA=
Date:   Wed, 23 Aug 2023 17:59:07 +0000
Message-ID: <20230823175903.bpumanwv5fkpwc44@synopsys.com>
References: <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <20230823021429.rlgixqehry4rsqmm@synopsys.com>
 <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
In-Reply-To: <5d5973b9-d590-4567-b1d6-4b5f8aeca68b@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA0PR12MB4381:EE_
x-ms-office365-filtering-correlation-id: d099b051-37be-46db-3f32-08dba402a553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /INdz1zsGolchsTr3F490dOwUD3TCya0hyVQmctxXX6pyTIZePK7YVTPQS7VxHw+VKla+hAl8hCHQJCTDHBa3nPH1iPmoX9prwch3qijZknSqfvEJdSkaXGo91QzN6CcQ30eSGiDoU+bltMVLzeWeJSxZHTq0O1QCBkZ3268cTgUuVE+7dWP+g9L8cW/e/8v4lq6HM7GB1JaP2xfnbV7mkM0vSAHDEwfXELx6S/dB0iYxs2GbuEukeXxeZ60DIUIiQx8beveG3PnfQUYzu2chqWG5dKl8xeahAU8FBlQ3JuDz9Hzs9CTmTw8F+pja2zAxhhXhHmdyiPfty+HDerhR+mBaEPEEROzA9kaYMaM5lHTeehBiCEddgZKL/LhSeOzwLF6eOPfEH3QhevLSMAab7ZnjWGNCORBaEwvM1sY59cGTAJc0G2IygHc4X6JeCP61NAe+0nGZ+jogwNFfSDuA/sNPNl3iIQSTSc3dlY7JbA07COGeJiY1CMbyLZ5Jm84wQV5ODfSGdaP2KgbAZWge7bKXYMKW2ck/2dYuNCdkq14HP1jU8AEgAmY5WZdZhnyh47IPoPJdGNCIQZ2ay75YB1ahQOXsOgE1LGc4qaDU2EdzFEcmPJzylMh5hXlRQST
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199024)(186009)(1800799009)(71200400001)(86362001)(36756003)(478600001)(5660300002)(8936002)(8676002)(4326008)(122000001)(1076003)(26005)(38070700005)(38100700002)(83380400001)(2906002)(6512007)(2616005)(6506007)(316002)(76116006)(66476007)(6486002)(6916009)(54906003)(41300700001)(66556008)(64756008)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2NqN3FkaXFHanAxTjlqU3JDdjNVaXFPWExGNVFxK1ozcmRRMEFCeFpEcnVZ?=
 =?utf-8?B?SFIvbWYzQjRicml0SjZETCtqMFFRZHJCblBKY28wS0E5cU9lZGFON01hUDFT?=
 =?utf-8?B?SnR6TWRIejJ1U0N1VUlJbkRYeng4NzdIc0lwS3pmRytRRzgvdFNxVi85VkZr?=
 =?utf-8?B?YVJYc1YvL0NHTW5GeFJ3OXE1emVHS2FGajRxNGIxY2ZzdG5kL3lDYXMzWnFZ?=
 =?utf-8?B?bjRoQlppeU5CYjdRTmRLWUtxT3pRSTYrQmlXdFdZcDVSZitCQVdKN3psa2Zw?=
 =?utf-8?B?cEJFb0dQZHRSMWhwcDFOWTBIZzgxV2RUY2prU0RMdWhNZXp6cDh5bVRHZFcw?=
 =?utf-8?B?T0JqVDFVN1I2L2RwdFdwUkJLQlVOeFZNNTBmVHpvd1FWWjhMSjZGdGVWMGtj?=
 =?utf-8?B?QXRCOEcxV25zRzN4NGpvcGRDT1NTbXJIVDNYMU1yYlpESnBUR0FXTDJMaE1y?=
 =?utf-8?B?STFrS3NPTXR2eTUwUktjMUZxN0Y2bVhmbjdBalVqd3Z1L1RpWXNhMURTZTJh?=
 =?utf-8?B?eEE0eHJEUklLbmNURDlSbGdKUit4RllESXFMM3JkeVp0WHRmZEo5b1NtMjU0?=
 =?utf-8?B?UFJxNGgxN25lRDdka20yUVhBQ2R6dXZ2eUY3MGhUWHRPdjZsaEJkc0lIa2U0?=
 =?utf-8?B?ZFBOb09rakp2SXhYWktCSnd6MXp5dTZtREFsTW83QkdwejRhVmlRNTRoTU9P?=
 =?utf-8?B?U2dEZUtsTml3TVB2djlFS2FMekFuZUxuSUozOUtOQmtsL0xnbmtCL1NJOGZY?=
 =?utf-8?B?NWU1cDlUbTUzK25oVERhRDNmaHo5bVdpRms3TGRTRnBNQzdyTUl0ZExvY3BH?=
 =?utf-8?B?SXRndUJUT1gweHcrdm5VM3JFY2JxRHEyVXhNaWovT3k4UFRva0tYMWNZb0lq?=
 =?utf-8?B?b1ZmakQvMFRoOGZyNzRGMnhaUFlDOHZFSktTdnBNdU1qMTBwL0k4dWE4VVVo?=
 =?utf-8?B?L1A2RElxTk9sNHhmQm1BNXQxS01QK2tUdUdEM3pubjZMYllLWXdoLzJZclNv?=
 =?utf-8?B?WE1yaTlabFlEeUxhTDRrb2hDczRXOEF4NzFMNDA1UXZpbmNESEFwa21KT2pZ?=
 =?utf-8?B?RnovZ21XR3RzdW1ISXhLclR4TTNyZWVIcmZLQkdPbThVc3J1dmdwZ0hsc1lX?=
 =?utf-8?B?RURjUG1IbVNGbmJFTkpXSmtkRlNmVmtsTDVjMm84VnVMNUQyTm9SODZjcmlz?=
 =?utf-8?B?ZjNwZWpVNzF6Mzk4UXNGNDRSVEZWYjNBdlRGNU53aFk4UUZ4K0NrNWxSWG5G?=
 =?utf-8?B?dkJWaFRBNGg3cFdweTI2MVN3OUdXeTF2d2ttYWloT3pYR1pwcDRMRjRNa3Y0?=
 =?utf-8?B?clBCa3l0cEJ0U3I1YytUT3VSRHdGVTNyZ21FeDd2VlN0WFRYS0QvN2g5TXpZ?=
 =?utf-8?B?UU90UzllYVQ2elpxZGZBbURodFdUelBQaXQ0SUgwSGs1MTA5cXNCZHhUM0Zz?=
 =?utf-8?B?TEt4cXdiNGZNU3NodzY1MFk0WmNsQmU5Q3I1VFdPSE1ucTRyVW1VVEdpZWJI?=
 =?utf-8?B?WndhNVA4SURXSzdQUG9va2NyTE1DbzlvVXFSem91QjkvaHZxczVmUC9Za2Zt?=
 =?utf-8?B?Qk93bTRvZGlGbEg2cEV5NHhpNEx2VWp1elBqa3ZNRHlxRlRyUDdzQ0FDWlJ6?=
 =?utf-8?B?Uy9oVVFyVUZITDVSRmQrdFRCUjF0bC9YZk4yOCs3WUhJMDdNbkFnOURKaU5p?=
 =?utf-8?B?Q0FIQlpMNXBGWWNSY0N1UDB6MEhOR0VoM0xkZFNxbndjNHBiWnRiaGVSNEl5?=
 =?utf-8?B?Rnd1Ylo2R1VVVHI4cGplaUZvWEhMYlpENU05OSt1Sk1NM0pIMEFNWlpPaGJP?=
 =?utf-8?B?Y05ULytiMHhNNlVlRW9RYmlqL2tRbTVzTlFrMzVUTTJ6YzJMQi9tUm5kdkxw?=
 =?utf-8?B?eWtzK2IwUi92ODBUdldUZStpK2p1MmgrbXZCVkdheTNPbitsR0RheTI0Y1d4?=
 =?utf-8?B?aHBrUDJYaHFIQ2FmWnFyVEVRNlBNS0RzSUJ1MG5pNWZkK0xzaGNxTjBBbEdu?=
 =?utf-8?B?a0ZZQ1JvT3FpMndGTDZ2SmRCcHBCaFhOMTF0dG4rWFdNazZwS3BhRTAwbGF4?=
 =?utf-8?B?SDU1Ynh2VmN5VUwvekxWYkRGbDFzUmM5K0pCQmZJejc2ZUJzWWxHcDNLTGc5?=
 =?utf-8?B?QWRneEpnSVZmMnRRZFNmVHR6NWc2cEZ6VFBCNG0vL2R3cUwwREZuQ0dSK2Rz?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D1AEAD47D02344E957E1F53E5A2264B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eGZJSUFSUTNGR2ord1RuRk02eVppbitQSjVvdnN5Y0xsL1YzV0U4L0ZxV2wv?=
 =?utf-8?B?KzBYMUxnM3dDMEgxRG1QUVY1RXpaOW4vL0pmaHZBUjZlc3RFd2JMTlh5RzI0?=
 =?utf-8?B?VVJDVjFwdmpSejdyTkt1bXRoeVBUeGFNUk13M1lVRXQ5TWppNUhTQ1QxS1Qx?=
 =?utf-8?B?RVZtWkloQnFzMWFwQWRxY1RqdHgyRE1jbHcvZDdEaEk4UzY3MVB4d1pEZ2pK?=
 =?utf-8?B?VGlhQy9weXdOaUJraTRYaW54MkZoU0p6QitEZ0JIdG5NYjJvRkNuMnExQVUr?=
 =?utf-8?B?ZFVMQmlwRExrVXB3aERMQnUzN2Z2eGFBNWc2RnlzU0wxTmR3d1FkdkdncExk?=
 =?utf-8?B?VzN4UFcxZllCb0RmaEpKODZWNFI3R3l4WUxKditYay9HSVhXdHJGTFJJdFQ3?=
 =?utf-8?B?RnRvM291Qld2WUZ0K08zdXNZQUdYamJIZjFTNVlvVjVFdEgwK0pLUVJIVmxV?=
 =?utf-8?B?RU9aaDBCalBUQVUrQ1lsOHJIMkh5SnpWOXN0NXFWTXM0QUx6ZGJkaG1aZ3RB?=
 =?utf-8?B?MDRoRHNuS2xtZ1B5YjJZQkYxK1l3U1V1T2lhaEc1ajNIYkUwbU8zdC9sY3M0?=
 =?utf-8?B?THdjcTdCQVhTdk80TTZQTFlRaFp4NENsbWtXM1cwWm1QaUo5VkFMb0dadXMz?=
 =?utf-8?B?MWNSSGs3SFpRWmc3cXIrV1JRVm83TWFqRlVMdUdrTk81SlVwUGJZZkhtU1BY?=
 =?utf-8?B?ZUJPQUN2K1ROVzFJNUF1Nm1BMzRNR0xiRzZVMmhOaHVjN1VyUXgzc0M0UzZa?=
 =?utf-8?B?YTI1QytqV2Ewc0p3ZUhSU05xMHAvSFRRS2tpcVE4SVRhdHFXY255NFk1Vmo2?=
 =?utf-8?B?c0piaUJxeEVZMk9wWUtZdkZiQUYvUExkWGkwcjB5ZURTZlRSbnNTUHZQOXE2?=
 =?utf-8?B?L2ZBZnp4M21HRnE2akMrQThTb3RPM1JpdUNnVGRIUUt5UGMreUFGd2tVbDdk?=
 =?utf-8?B?NFhkQVl1UzJNMlFlRXhLOEFJVE15RWhBcVE0dDYrbFExZzZqT1J5b1lTTHYw?=
 =?utf-8?B?aHZhUklLeVp6N2lsY3paN29aYWJ5OGlWeTNNbnlySzlhbHArMFJCQ3doNTF6?=
 =?utf-8?B?YStOYW44bHQ4NlVFdEtqdjhsNnRIRW1GaHRscjdGa0FPOG9mSHBMQjdvQTRo?=
 =?utf-8?B?UWcwdTdqdDQ4QlpReHY5TWo5a3BXS09PSE9YMHZhMHJ1Ni9WRjZ2MUNybjRl?=
 =?utf-8?B?ZzJndUJ3NzVOMk80NlYxRkdtWVB0OHRCNUdEL1UwTUNNR1ZlcTkzTTF2Q1M5?=
 =?utf-8?B?REFYMktMVmRJaS9wcUxPc3cxRGc0TkFLMzhKR2NpZng0Ymw3UT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d099b051-37be-46db-3f32-08dba402a553
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 17:59:07.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZjd0Qg5EvVh6fLJ14XLzKItwhPY6CbZSM9yDNCUXkZBMwDv1QZj+976hLC1jBMvI6I+QjuGGlRiQQdxDiB9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Proofpoint-ORIG-GUID: _Tng21aQwxz2iys8LGMRaSRJ0RMr-26X
X-Proofpoint-GUID: _Tng21aQwxz2iys8LGMRaSRJ0RMr-26X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_12,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMjMsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDIz
LCAyMDIzIGF0IDAyOjE0OjMyQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBT
dW4sIEF1ZyAyMCwgMjAyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+IE9uIFNhdCwgQXVnIDE5
LCAyMDIzIGF0IDEyOjA2OjUzQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4g
T24gRnJpLCBBdWcgMTgsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4gPiA+ID4gQWN0dWFs
bHkgSSBhZ3JlZSB3aXRoIHlvdS4gIFdoZW4gYSBuZXcgU0VUVVAgcGFja2V0IGFycml2ZXMgYmVm
b3JlIHRoZSANCj4gPiA+ID4gPiBvbGQgY29udHJvbCB0cmFuc2ZlciBoYXMgZmluaXNoZWQsIHRo
ZSBVREMgZHJpdmVyIHNob3VsZCBjYW5jZWwgYWxsIA0KPiA+ID4gPiA+IHBlbmRpbmcgcmVxdWVz
dHMgYW5kIHRoZW4gaW52b2tlIHRoZSAtPnNldHVwKCkgY2FsbGJhY2suICAoSSBkb24ndCB0aGlu
ayANCj4gPiA+ID4gPiB0aGVyZSBpcyBhIHN0YW5kYXJkIGVycm9yIGNvZGUgZm9yIHRoZSBjYW5j
ZWxsZWQgcmVxdWVzdHM7IG5ldDIyODAgc2VlbXMgDQo+ID4gPiA+ID4gdG8gdXNlIC1FUFJPVE8g
d2hlcmVhcyBkdW1teS1oY2Qgc2VlbXMgdG8gdXNlIC1FT1ZFUkZMT1cuKQ0KPiA+ID4gPiANCj4g
PiA+ID4gVGhvc2UgYXJlIHZlcnkgb2RkIGNob2ljZSBvZiBlcnJvciBjb2RlcyBmb3IgY2FuY2Vs
bGVkIHJlcXVlc3QuIEV2ZW4NCj4gPiA+ID4gdGhvdWdoIHRoZSBnYWRnZXQgc2lkZSBkb2Vzbid0
IGhhdmUgdmVyeSBkZWZpbmVkIGVycm9yIGNvZGVzLCBJIHRyeSB0bw0KPiA+ID4gPiBmb2xsb3cg
dGhlIGVxdWl2YWxlbnQgZG9jIGZyb20gdGhlIGhvc3Qgc2lkZQ0KPiA+ID4gPiAoZHJpdmVyLWFw
aS91c2IvZXJyb3ItY29kZXMucnN0KSwgd2hpY2ggaXMgLUVDT05OUkVTRVQuDQo+ID4gPiA+IA0K
PiA+ID4gPiBXaGVuZXZlciBJIHNlZSAtRVBST1RPLCBJIGFzc29jaWF0ZSB0aGF0IHRvIGEgc3Bl
Y2lmaWMgaG9zdCBlcnJvcjoNCj4gPiA+ID4gdHJhbnNhY3Rpb24gZXJyb3IuIEZvciAtRU9WRVJG
TE9XLCBJIHRoaW5rIG9mIGJhYmJsZSBlcnJvcnMuDQo+ID4gPiANCj4gPiA+IERvIHlvdSBoYXZl
IGEgc3VnZ2VzdGlvbiBmb3IgYW4gZXJyb3IgY29kZSB0aGF0IGFsbCB0aGUgVURDcyBzaG91bGQg
dXNlIA0KPiA+ID4gaW4gdGhpcyBzaXR1YXRpb24/ICAtRUNPTk5SRVNFVCBpcyBjdXJyZW50bHkg
YmVpbmcgdXNlZCBmb3IgcmVxdWVzdHMgDQo+ID4gPiB0aGF0IHdlcmUgY2FuY2VsbGVkIGJ5IHVz
Yl9lcF9kZXF1ZXVlKCkuICBXb3VsZCAtRVJFTU9URUlPIGJlIG1vcmUgDQo+ID4gPiBzdWl0YWJs
ZSBmb3IgcmVxdWVzdHMgYXR0YWNoZWQgdG8gYW4gYWJvcnRlZCBjb250cm9sIHRyYW5zZmVyPw0K
PiA+ID4gDQo+ID4gDQo+ID4gVGhhdCB3b3Jrcy4gSXQgd291bGQgYmUgZ3JlYXQgaWYgd2UgY2Fu
IGRvY3VtZW50IHRoZSB1c2IgZXJyb3IgY29kZXMgZm9yDQo+ID4gZ2FkZ2V0IHNpZGUgYW5kIGtl
ZXAgdGhlbSBjb25zaXN0ZW50IGFjcm9zcyBVREMgZHJpdmVycy4gSSB0aGluayB0aGVyZQ0KPiA+
IGFyZSBvbmx5IGEgZmV3IGNvbW1vbiBlcnJvcnM6DQo+ID4gDQo+ID4gKiBSZXF1ZXN0IGFib3J0
ZWQNCj4gPiAqIFJlcXVlc3QgZGVxdWV1ZWQNCj4gPiAqIFNUQUxMDQo+ID4gKiBEYXRhIGRyb3Bw
ZWQgKGlzb2Mgb25seSkNCj4gPiANCj4gPiBBbnkgb3RoZXI/DQo+IA0KPiAqIE92ZXJmbG93DQo+
IA0KPiBTVEFMTCBpcyBub3QgYSB2YWxpZCBzdGF0dXMgZm9yIHVzYl9yZXF1ZXN0cyBvbiB0aGUg
Z2FkZ2V0IHNpZGU7IGl0IA0KPiBhcHBsaWVzIG9ubHkgb24gdGhlIGhvc3Qgc2lkZSAodGhlIGhv
c3QgZG9lc24ndCBoYWx0IGl0cyBlbmRwb2ludHMpLg0KDQpUaGUgaG9zdCBjYW4gc2VuZCBhIENM
RUFSX0ZFQVRVUkUoaGFsdF9lcCkuIFRoaXMgd2lsbCByZXNldCB0aGUgZGF0YQ0Kc2VxdWVuY2Ug
b2YgdGhlIGVuZHBvaW50LiBJbiB4aGNpIHNwZWMgKHNlY3Rpb24gNC42LjgpLCBpdCBzdWdnZXN0
cyB0bw0Kc2VuZCB0aGlzIHdoZW4gdGhlIGVuZHBvaW50IGlzIHJlc2V0LiBUaGUgZW5kcG9pbnQg
aXMgcmVzZXQgdHlwaWNhbGx5DQp3aGVuIHRoZXJlJ3MgYSB0cmFuc2FjdGlvbiBlcnJvci4NCg0K
VGhlIHByb2JsZW0gaGVyZSBpcyB0aGF0IHR5cGljYWwgcHJvdG9jb2wgc3BlYyBsaWtlIE1TQy9V
VkMgZG9uJ3QNCnNwZWNpZnkgaG93IHRvIGhhbmRsZSBDTEVBUl9GRUFUVVJFKGhhbHRfZXApLg0K
DQpGb3IgV2luZG93cyBNU0MgZHJpdmVyLCB3aGVuIHRoZSBob3N0IHJlY292ZXJzIGZyb20gdGhl
IHRyYW5zYWN0aW9uDQplcnJvciwgaXQgc2VuZHMgQ0xFQVJfRkVBVFVSRShoYWx0X2VwKSBhbmQg
ZXhwZWN0cyB0aGUgdHJhbnNmZXIgdG8gYmUNCmNhbmNlbGxlZC4gVG8gc3luY2hyb25pemUgd2l0
aCB0aGUgaG9zdCwgdGhlIGdhZGdldCBkcml2ZXIgbmVlZHMgdG8NCmNhbmNlbCB0aGUgcmVxdWVz
dC4gRHdjMyBuZWVkcyB0byBub3RpZnkgdGhlIGdhZGdldCBkcml2ZXIgb2YgdGhpcy4NCg0KRm9y
IG90aGVyIGNsYXNzIGRyaXZlciwgaXQgbWF5IGV4cGVjdCB0aGUgdHJhbnNmZXIgdG8gcmVzdW1l
IGFmdGVyIGRhdGENCnNlcXVlbmNlIHJlc2V0Lg0KDQpBcyBhIHJlc3VsdCwgZm9yIGFuIGVuZHBv
aW50IHRoYXQncyBTVEFMTCAob3Igbm90KSwgYW5kIGlmIHRoZSBob3N0DQpzZW5kcyBDTEVBUl9G
RUFUVVJFKGhhbHRfZXApLCB0aGUgZHdjMyByZXR1cm5zIHRoZSByZXF1ZXN0IHdpdGggc29tZQ0K
c3RhdHVzIGNvZGUgYW5kIGxldCB0aGUgZ2FkZ2V0IGRyaXZlciBoYW5kbGUgaXQuIElmIHRoZSBn
YWRnZXQgZHJpdmVyDQp3YW50cyB0byBjYW5jZWwgdGhlIHRyYW5zZmVyLCBpdCBjYW4gZHJvcCB0
aGUgdHJhbnNmZXIuIElmIHRoZSBnYWRnZXQNCmRyaXZlciB3YW50cyB0byByZXN1bWUsIGl0IGNh
biByZXF1ZXVlIHRoZSBzYW1lIHJlcXVlc3RzIHdpdGggdGhlIHNhdmVkDQpzdGF0dXMgdG8gcmVz
dW1lIHdoZXJlIGl0IGxlZnQgb2ZmLg0KDQo+IA0KPiBSZXF1ZXN0cyBjYW4gYmUgYWJvcnRlZCBm
b3IgdHdvIGRpZmZlcmVudCByZWFzb25zOg0KPiANCj4gCVRoZSBlbmRwb2ludCBpcyBiZWluZyBk
aXNhYmxlZCwgZWl0aGVyIGJ5IGFuIGNvbmZpZy9hbHRzZXR0aW5nDQo+IAljaGFuZ2Ugb3IgYmVj
YXVzZSBvZiBhIGRpc2Nvbm5lY3QNCj4gDQo+IAlUaGUgcmVxdWVzdCB3YXMgZm9yIGFuIGFib3J0
ZWQgY29udHJvbCB0cmFuc2Zlcg0KPiANCj4gUHV0dGluZyB0aGlzIHRvZ2V0aGVyLCBJIGdldCB0
aGUgZm9sbG93aW5nIHN0YXR1cyBjb2RlczoNCj4gDQo+IC1FU0hVVERPV04JUmVxdWVzdCBhYm9y
dGVkIGJlY2F1c2UgZXAgd2FzIGRpc2FibGVkDQo+IC1FUkVNT1RFSU8JUmVxdWVzdCB3YXMgZm9y
IGFuIGFib3J0ZWQgY29udHJvbCB0cmFuc2Zlcg0KPiAtRUNPTk5SRVNFVAlSZXF1ZXN0IHdhcyBj
YW5jZWxsZWQgYnkgdXNiX2VwX2RlcXVldWUoKQ0KPiAtRVhERVYJCURhdGEgZHJvcHBlZCAoaXNv
YyBvbmx5KQ0KPiAtRU9WRVJGTE9XCVRoZSBob3N0IHNlbnQgbW9yZSBkYXRhIHRoYW4gdGhlIHJl
cXVlc3Qgd2FudGVkDQo+IAkJKHdpbGwgbmV2ZXIgaGFwcGVuIGlmIHRoZSByZXF1ZXN0J3MgbGVu
Z3RoIGlzIGENCj4gCQlub256ZXJvIG11bHRpcGxlIG9mIHRoZSBtYXhwYWNrZXQgc2l6ZSkNCj4g
DQo+IFRoaXMgYXBwbGllcyBvbmx5IHRvIHRoZSAuc3RhdHVzIGZpZWxkIG9mIHN0cnVjdCB1c2Jf
cmVxdWVzdC4gIENhbGxzIHRvIA0KPiB1c2JfZXBfcXVldWUoKSBtYXkgcmV0dXJuIGRpZmZlcmVu
dCBlcnJvciBjb2Rlcy4NCj4gDQo+IEhvdyBkb2VzIHRoYXQgc291bmQ/DQo+IA0KDQpUaGF0IGxv
b2tzIGdyZWF0IQ0KDQpUaGFua3MsDQpUaGluaA==
