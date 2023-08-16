Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE6977EDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347195AbjHPXoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbjHPXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:44:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0EF2727
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:44:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GNfBb0032201;
        Wed, 16 Aug 2023 23:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4n0asc9xpFYyQECFHNPgd3qjtAaJtO4WP5RzeEVG+u0=;
 b=AnCAM/BEJN5F0ZEhxgfOk09VfSkJoEOFrOQeqYaqcCELUC6fC57jxMdX/wns+AghdNoR
 YaIEc9Od7QRuUwP7okewnUkVIx27a6NejOs9qikn/9/J2RR91QIuh/NtwsMctejt/o44
 iVtHXq0Hgs1ljnaWDalgvn3gw1s38UFUC7491E37DE3vQ9/M5opLa9BTGyfStnj6TOk4
 IeoJeH26xnKqnmoCrjHZll2TavQ0CPNtJa7LhkSomFqXxWK5zbAZgN5Xu/Crr0FARjCk
 0OdBxAE4oSdKYafVVhSGcV6OnkF2VEZF1u3zLd8odmure0r56OUtdHF41+7IdVtGwQoB aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwrca4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 23:44:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GLACBE019811;
        Wed, 16 Aug 2023 23:44:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3xdrry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 23:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLfsB7hzMxmUdmih8dGIxKT3xbxrM6qmaxWfs53eKSseg+lZo/XdWFPQrZGx6y/CK/7l6Qa4IrfR6T2NmFRQeli9r+PQbCi8YdBbo4a/as2M4L2jfRu1uc3A3cqQ9E8c71qMcCVgWYk20PA4iY9501SJK+fkZ2sVXCETgoPbcOsj1swxuue0S4v14HrojVXZUOT/15cIKVEcSIOQjVy3T4yBIZ19p+4K7Qagdev7fmeYLUG1ZYA3XmKK8yZR1fxYo/ozg+Lji2XqOtjPMnpNKj0lWxgnp9gF7Ep3UPeNWJDn+Z124tUyudi8cNhL5IreapZuygaEk2r1jngO01grgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n0asc9xpFYyQECFHNPgd3qjtAaJtO4WP5RzeEVG+u0=;
 b=JB71q3lrorVV05JcOo4mgvsp8FptiC264hlOPiDrE5wBZNe5wcN3tmOV7XdIUBLnfn5QG5FR4WO5sxgja84RFtI8MG0/aUqtBuWeN4DvaGIh819OS5iluVHgEswWFWVRLQVTUdEUUMZlZSNd9Le+XABF2+ZSKCIaplwLsbpLMzAVk+RNtsbnjhjSuIZusql7sS8ORhLLbaSEocRy2l+ZoXdi4jslx80jq12gnZ362520m2cQXL6Y/O58N+SrmqfjghIyvURUeHtMaw3l+xYGeVmLzQ16NknqwCnoeLeHNExJC0J53285Ovdjdi/Kjm+dPbbVQ3E4XoXYkVIRPUZ3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n0asc9xpFYyQECFHNPgd3qjtAaJtO4WP5RzeEVG+u0=;
 b=tqYWPD4bMI53XZKeeW3qfn7ITXuYGdo17oyQOysFOuGza3SB2iGeTPV6N4Eq77R7MVx+BhNSve7XYZrAD6HTG7upNAJyaV99TrMOOQ+g9XD9y35PzQQ9tAHAnYS07agQEXtvXbLUYKVhPtM9xKlOL7FJ7k3Xcd7x6RlTtMFPsYg=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 23:43:57 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 23:43:57 +0000
Message-ID: <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
Date:   Wed, 16 Aug 2023 16:43:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
 <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
 <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:806:d0::17) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA2PR10MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 93cddc83-2f89-46b0-6c19-08db9eb2a895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uN6YoKVtZMIRPLu34rFTR6gmDaaqrfg0acHlSLiDOacOZ+3j25cbM+/WwN3jfr5jOoVIhTLmJwxkThOqAvyGw6by0dRxasUqYfyw1z8Uz8pJbJvEGxhO5PG/WKJv5svgvc80x/yui0A9soe4yEqxiOe9kpFNA7YOvaWQ6ohxCOz5P3KlWxSxeIq5JbncE+lU36LZN6oUwc5Q5LXfsFbNuJ+PaugKUrdhgxU6iFQy0QPMU4v9h+hNZ0ow6yWtY0XX/d9xlmFoizk6vNvC5Nqk8wXRHGmpqMdTh+I/Up+PRdbuE+U1kK617BC4RAdKWslKTgfxco/ztjadnJx9OVNtJ45B5RtjenDZ3JGvRRpwvQegaJO5yOhvZMx+pcwlX45ubDl+6HRaWjBdnPbzzZhkTHA+nvJ4FLJVpq3/q1aCxgMSPvCv5cM3ks2MV1lvWp0BiBWhi77ag50qVQ930S2zVZbm9oLYAq/aYzGLEW3MYgyFARUWiXQClCD/Z0ZlvmH+1/4qMFW1ZX9LZQIWTBuIecIXQvtPuWNhjGBoSMN+BEpSL9k/ck2qKArROiVrPOMjDeE2cFeWt2V5ZSJHQRh51ElJBNnU0kdKZx6+VbUDwts9LUZdalRPjr8WknPltN7DJ3s1fO8H1R6/e5bszhxmbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(31686004)(5660300002)(41300700001)(38100700002)(8676002)(4326008)(8936002)(66899024)(2906002)(83380400001)(26005)(478600001)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(36916002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29KQ1o1SnlHeTU0eDd3dDJ5eE9IcDlGSmRwYXZXckQ0bUJMdTNhYVFYVk8r?=
 =?utf-8?B?UW1OQWp5Rk1kNzdHc0VWdGQ3TU9rck9xWFJYWUpsVmpFS3ZkbTFNbmhSeS9U?=
 =?utf-8?B?MnJsdTJCUjArVnBLMTQ2V2N3NEdPaWY3NWVHSHExU0hlaWNTQWVtZ1IrcXlK?=
 =?utf-8?B?WFRzY2t1ZUZkRVM4dUV3STFYZGhESjBMa1ZGNmpHT0I3cmNQMndKcVU5VlRB?=
 =?utf-8?B?Rng5cUdwaFBkZ1kvNEtHaXBkQkwvejAwZFB2YmR1a3ZHcURvZGJ6MjZlRFBY?=
 =?utf-8?B?WGl6Ym5NUURlS1lXWDV4VWp3cU9ma0Vad1NURGFQdG9pWVdxL2JBdUgvK0JC?=
 =?utf-8?B?MHVuTmMzb1FlMVRWcjBQSXhWRnliMWRWM0ovREhEWllBaEhKQWgyUDhEclpa?=
 =?utf-8?B?R3VWV2c1SWZSanE1VFVRejJCaGhYUFlMR3hXMW1QbG5MRVNXcFk3QW1jak9s?=
 =?utf-8?B?ZFFrWkVud3gxb1VSSHl0cHJaMTJlOTg4R2dQM0dLalZqSDNrRlhRSnRrQXQ3?=
 =?utf-8?B?MW5QN3E5MWlWSnZuajNYZEhvSFFpZGF6NGZIVDh3SlFqMys1QlNIRTN3OC9U?=
 =?utf-8?B?endjekFpaTNqbDhQQ3R4aEUxRENOblZGYkNtdHh6S1UvSDY5SzA4VEs3L0cy?=
 =?utf-8?B?WDV0cmlucy85T2c4bW5iMHdXZjY0NkZ1aThRcW5RbWpBYUFCQWFCRHh0S3VI?=
 =?utf-8?B?NkRsOTRwa3AvK0FKOWhxNCtJY0lFU1N2NUNKVEo3Q052TVBaZEZkY0FaYUxL?=
 =?utf-8?B?UGI5cnlRNGlONFRXd2ZJVlhzZFdvS0tKOTRRQlg5eTNoMUUzaXFKMXAxc0Rm?=
 =?utf-8?B?em5NTk9mSGY1MWtMZmxYbWJtTFpJenJuMk9GSUZPeHp4djN2akRNN0loRHZK?=
 =?utf-8?B?NmxRUkdFZGJrc1FyYy9GR1RqZUlxcGl2aTFIazk2eVZvdjYxSkp5ZnRLbnVZ?=
 =?utf-8?B?UnBIV2kwUlhjWXZKL09LNlpUY01HVnFTOThCTjFCV01zb2JhQ1lOU2RCZXdi?=
 =?utf-8?B?bi90VXF0TEt3MzJ0bEU1cGp2ZTlObkg3NEFJVTdKNS80L2Z1MVhWdXZER3RG?=
 =?utf-8?B?bzF4TE5sOTYzTHB1dWszY1c1Z2NoNjlSak9GTDliSHRhMENaNXhtWXM3M1lp?=
 =?utf-8?B?Unp1ODh4alppQWdGeENvZVhlZ2puUWZlWDVpcFhQSGpjZk44RGQrT1BYU1Fx?=
 =?utf-8?B?Yk9SUzFJRHdNRUpJeEJuRDJxVHYydllOZXFOTWUzZVhrL25pdXpGSkFZTElN?=
 =?utf-8?B?Qy9CMmoxeTNKN0J5dDMvNzJnMTRxbjhPTGdUNlBnNEZ0Y2pYSWNVRGErV1RS?=
 =?utf-8?B?aWJYRHo2Y1RUbUJMeFhhdk5qKzhxRnJDbldmNDNHbmVVM1AzU3crdVREQWhI?=
 =?utf-8?B?SHprSUg2QUNTdUpnTE80UHVDY2JBeG1BV2RzLzlxajlRU3J5ZVpucFZJdVRr?=
 =?utf-8?B?VjNiQWc3YUV3M2Y1Qm0rMkxZSDNOYmVRNkszb1dnWElhTmZtamJQYU1xRkJo?=
 =?utf-8?B?NEVhb3lqcnQ4MUNqUlNkK0N3NmcrMzNpQ1VEWk5qdGovUitkMjNqV0pWaGFr?=
 =?utf-8?B?Uk9ucXNUS2pic3NEdno0aW1saU4wcWsraHkwdWpmTGtBK2pyTFg5dE5HU0dE?=
 =?utf-8?B?STB2eG8wWTNjMEFIekM1THJKSngxai9vbUJxYWsxQWpJTjRJcTB2bE4zWVhB?=
 =?utf-8?B?V25DKzJkUDBYNE9McXptbWV4MmJ2STdvSEdtZHRMMWNGV0hwU09UVFRydGNs?=
 =?utf-8?B?SzFCV0Z2WUlWOTZFOE12S0krTHJnbWxXa2tlcFNxUUppNUFlQ1YySWpCY1JH?=
 =?utf-8?B?azRnOFBjZWFxMkZVNEdoZDhZZlJuNFl4Uks2RldLWDh2b2NTQmtPV3Z4NzZQ?=
 =?utf-8?B?cnRDcjJad2tud28ydEcrOUFSM2xWKytTcUVrdnF1ay9xRGNaeStqVm8rWDZU?=
 =?utf-8?B?M0I5VmlFWDJjYkM3TGJDU2lxRnBUWjduQVJJREpFU0U0QzZKVnZqUzlnU0pJ?=
 =?utf-8?B?U0pvbUZ5UGlJMkhUaU9VNjhrZitIMmROWWtUZ2oxQ29ER2FKVkg1ayt3QjlF?=
 =?utf-8?B?cWlCb0dnYzV3a0ZQbG9RWU1Dck9rY1BqSWdZOUM4Y0p2alhTeGFIdEl6emhw?=
 =?utf-8?Q?ACTdSM1YynOOJBCPw41l5i3FE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a0gvQUwzODZvUkxWYmtzK21lMCtRUFhTN0lBU2YwZzM1QkJ4amFRYWQwVXcz?=
 =?utf-8?B?WW1OelBqZzIyRG9qRFp5ZFRRRUNmelNBZXBxbmsyZ0wyTUd3MC9yZHpNSkdU?=
 =?utf-8?B?dUlWcktjVE1Ubm5JMkdqbUNHSjZRclZndGpOb3dIdy9EMlZhLzVEcGxLM0lT?=
 =?utf-8?B?aEdMNDlEZElOTkFxcGkzd0prelNNTzdQTklvdEJGN2dXZDhxRGdLODZqQ2FW?=
 =?utf-8?B?NkhPUlQwcjduRHZYMml6cktzdFhKZ0VQNHRET1BZdnB4WG04U3ViTlJWVlhP?=
 =?utf-8?B?WHdSMnBING1kODNteXNCWXVBLzhYTHRvSDdKczM4azVmc1VxNlFCaEo3NU9Z?=
 =?utf-8?B?VGZjdituTEJvZHQ3S2hEbTZ0bXhrNWZkdEkxTnhER3F5RWF0bkQyN3cvVE04?=
 =?utf-8?B?aXpkZzhES1dHSjE3VkY4aXB3QWtQMCtwd1JxNDdiZTduRGtOWHZkVXNxNzF4?=
 =?utf-8?B?NDhiaUJVc3JGNnRzNi9mNG42WVVmTmp3dGl2ZmZoMlhmSjRvWGlKZ1Btbnln?=
 =?utf-8?B?MGhWZUYvOGZhbkxEWFZSVGc3VG9nU2ZRSUhQQ0R6SnNwYlJFa0tBTCtJdms2?=
 =?utf-8?B?MXA4ZkRqM0E2b3AzRkxyZTAzLy9LRFVMUmt5enpTbDh4bU0ybC9wNlVPS1BH?=
 =?utf-8?B?Y2RIajN3WWdWRWhQdERNbGNZcldLV09QZVArcUdaaENlc3ZRNXFSNnNNRk41?=
 =?utf-8?B?TlI5Zy9yTXFYK0ZSb3dwM1d2cU94OEl4cW9TZTg5SVBITmFraWJNSnhaQVZE?=
 =?utf-8?B?UG8vZE4ySHd4QlBhS2F0Z2tURGZjR0I5V1lOZEVneTBrOTU3ZjJTYnJRWmpi?=
 =?utf-8?B?SFlsMWIyclhJcXhtdlpFZjhEbERvT1lUSEtJcUJ3OFJtUzVaN1ZYcU8raWox?=
 =?utf-8?B?bE1aa2J5T2F6S1pqMDh2UGpSNkthNS9KSGpIY3gyVEVoZElCUFZ3a0NOc1Nn?=
 =?utf-8?B?QldaZDQyKzVjREtoYTVWdHJtVTZkK2VoRkNTMW5tL1BZdDd6TU42MEhOaTJW?=
 =?utf-8?B?VU1YUzZqWWpVZThyRUM2T1IrV0luOVZrWG4vNTdKbEVCUDNwTWFPMEVjSDBo?=
 =?utf-8?B?QmMwSEUxeUEvZVFhTHNlQm1qeS9vTlBDUmlSVnoveWF5MEJXL2xoaHE1cUJl?=
 =?utf-8?B?TG5qdDBtakszc3NsbmJRSU9BQmlCZ0drVE5ZbnBpRVUwVVp1ZHY2UUU5V3o2?=
 =?utf-8?B?RzUvM013d3hra29HcS92dmlRS0ZobVJ4TEt3TWpYWFQrdHpoQkNDeW4vUkJ3?=
 =?utf-8?Q?VcBfuNrYXMjK0TT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cddc83-2f89-46b0-6c19-08db9eb2a895
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:43:57.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEhZLD0dEdIi8Gx+zuUhxeh736qPrJM/mzR+emKw6Wc10BFEx1vBMwwQoRAZTmhm2RQme1u3uaatcXyDTHGs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160211
X-Proofpoint-ORIG-GUID: N2p5B5u87rKUvq2TItfpccl12uZc1cJh
X-Proofpoint-GUID: N2p5B5u87rKUvq2TItfpccl12uZc1cJh
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 6:48 PM, Jason Wang wrote:
> On Wed, Aug 16, 2023 at 6:31 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/14/2023 7:25 PM, Jason Wang wrote:
>>> On Tue, Aug 15, 2023 at 9:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> ---
>>>>    drivers/vhost/vdpa.c             | 16 +++++++++++++++-
>>>>    include/uapi/linux/vhost_types.h |  2 ++
>>>>    2 files changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index 62b0a01..75092a7 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -406,6 +406,14 @@ static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
>>>>           return ops->resume;
>>>>    }
>>>>
>>>> +static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *v)
>>>> +{
>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>> +
>>>> +       return (!ops->set_map && !ops->dma_map) || ops->reset_map;
>>> So this means the IOTLB/IOMMU mappings have already been decoupled
>>> from the vdpa reset.
>> Not in the sense of API, it' been coupled since day one from the
>> implementations of every on-chip IOMMU parent driver, namely mlx5_vdpa
>> and vdpa_sim. Because of that, later on the (improper) support for
>> virtio-vdpa, from commit 6f5312f80183 ("vdpa/mlx5: Add support for
>> running with virtio_vdpa") and 6c3d329e6486 ("vdpa_sim: get rid of DMA
>> ops") misused the .reset() op to realize 1:1 mapping, rendering strong
>> coupling between device reset and reset of iotlb mappings. This series
>> try to rectify that implementation deficiency, while keep userspace
>> continuing to work with older kernel behavior.
>>
>>>    So it should have been noticed by the userspace.
>> Yes, userspace had noticed this no-chip IOMMU discrepancy since day one
>> I suppose. Unfortunately there's already code in userspace with this
>> assumption in mind that proactively tears down and sets up iotlb mapping
>> around vdpa device reset...
>>> I guess we can just fix the simulator and mlx5 then we are fine?
>> Only IF we don't care about running new QEMU on older kernels with
>> flawed on-chip iommu behavior around reset. But that's a big IF...
> So what I meant is:
>
> Userspace doesn't know whether the vendor specific mappings (set_map)
> are required or not. And in the implementation of vhost_vdpa, if
> platform IOMMU is used, the mappings are decoupled from the reset. So
> if the Qemu works with parents with platform IOMMU it means Qemu can
> work if we just decouple vendor specific mappings from the parents
> that uses set_map.
I was aware of this, and if you may notice I don't even offer a way 
backward to retain/emulate the flawed vhost-iotlb reset behavior for 
older userspace - I consider it more of a bug in .set_map driver 
implementation of its own rather than what the vhost-vdpa iotlb 
abstraction wishes to expose to userspace in the first place.

If you ever look into QEMU's vhost_vdpa_reset_status() function, you may 
see memory_listener_unregister() will be called to evict all of the 
existing iotlb mappings right after vhost_vdpa_reset_device() across 
device reset, and later on at vhost_vdpa_dev_start(), 
memory_listener_register() will set up all iotlb mappings again. In an 
ideal world without this on-chip iommu deficiency QEMU should not have 
to behave this way - this is what I mentioned earlier that userspace had 
already noticed the discrepancy and it has to "proactively tear down and 
set up iotlb mapping around vdpa device reset". Apparently from 
functionality perspective this trick works completely fine with platform 
IOMMU, however, it's sub-optimal in the performance perspective.

We can't simply fix QEMU by moving this memory_listener_unregister() 
call out of the reset path unconditionally, as we don't want to break 
the already-functioning older kernel even though it's suboptimal in 
performance. Instead, to keep new QEMU continuing to work on top of the 
existing or older kernels, QEMU has to check this IOTLB_PERSIST feature 
flag to decide whether it is safe not to bother flushing and setting up 
iotlb across reset. For the platform IOMMU case, vdpa parent driver 
won't implement either the .set_map or .dma_map op, so it should be 
covered in the vhost_vdpa_has_persistent_map() check I suppose.


Thanks,
-Siwei
> Thanks
>
>> Regards,
>> -Siwei
>>> Thanks
>>>

