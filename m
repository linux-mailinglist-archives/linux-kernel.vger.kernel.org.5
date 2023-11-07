Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869907E4B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbjKGWCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjKGWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:01:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915C72137
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpwA026315;
        Tue, 7 Nov 2023 21:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=gIURl4zD2JDLDcBd66nrEQyeZ018E3Wv9BPvPmcIeRg=;
 b=2n+1QgJ9Me/2M8jpXCyLJSsPz6nu/XLFbGouS1eV3i+HgUvk09igKBLjPm0AIQ1p07AK
 8HH/K9JjjYbg5KnreQv5/afJhPFkPzJJrVu8tDzFM4ZrEIRFhYdIs43FNoD9+CP1FCD7
 VWvNvC6koqfOfnD7qecyBxYjsShBqVoayXGgP9cSbG4mgmbsTB5y8llLqHopjmLevTZ5
 tbk+cXlJrhAme6a9bgYHvidYXwxU+sI8Of4LXA3SiRDFNEmiQT6T6aVgbkoBpBqEQwiH
 WocaKnY2KTMNHB/xo916fIapqdFrGeg590GSsnhz3/Dh6riEpmixLKtrQNuS69HlasX9 gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2102ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPfS023842;
        Tue, 7 Nov 2023 21:59:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241ftt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtBprEZzNwWIxbxwq4YoRLkwh+K94LM1ym0KL1CfXoahn2SN4GeLZFo5tf7YYaGWmF0kjgJbid1rmKTKpX7EQdrSsCdwr1l0XG41PYw8zqiBBh5UV1usohfOW9Q5xxQb/+ATRPKFbzI8I4VRGAIC7Sdo7cngo6cjO4Zd5b9rLo523dqRqF+hzbBKeQQqGDDLuJyPWLzdjvPAIf9uOu1klwUOiBozrPm6ZKGI/3Sw+d+wLrPDYH2ghL0GlKyBIW2zu8vgs+F10HvqgMskS9sD4U2uMg63tf+Zh6h0LeD4fwK7tjaAyDStNUYzbJKbSaOI8kj20SWiwMQ12ZvAQcteRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIURl4zD2JDLDcBd66nrEQyeZ018E3Wv9BPvPmcIeRg=;
 b=hbPpBedb4SZ8pMnsFEYUINT2IiEgTuPUlrOtIE0rMwxA8jxDO5b3SO1z3NpCXrmvQSASi6A7XVa9SDX20PJvJB/orMzyPOK0SHV+JpljvdfeJ3ei7KqANns9ycsNTMF4eGxcH+NP/D8I2zlE3Wq7XsVz2NISRLu0eE5nncMCY8MqGBbZHOlmtfbIdfriHWI9A3Za9svRLaq3mjZnIlHVyG/EMqF8IfOYGpY+mH6ZneSEqNdMt+cb2ZJxGf+1ChHbk5rQi0UIDuX76rNQk4BdEfEE9RxJUt/mMI4FwEJmsN1cfMhIXVqg/AW2yYKWr/GAoFVIcM42QHN+LXxsJu+l5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIURl4zD2JDLDcBd66nrEQyeZ018E3Wv9BPvPmcIeRg=;
 b=RmL0qOEYoYayx1cVDYheoO04UJvTuPq8JfcuINfvgW5NiBllyyAZ/S1tLvz9DBA4ADB8c1KfyZTIBidkUebwyGyoPLgK08OOLqtKxmqDvvq4FunK1JBjhJRc0wXHnOTGQxBv84u/simS4ZVsl9OLrfGzWWTNVWkLBD7+6v/CfQc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:59 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 25/86] Revert "sched: Add /debug/sched_preempt"
Date:   Tue,  7 Nov 2023 13:57:11 -0800
Message-Id: <20231107215742.363031-26-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 30081449-50cf-4bcf-f75c-08dbdfdcbeb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cK9L+CHR0Aj1E7kPMJP+m+/5KhY+Ks2RqHgLboXRQywb2WuwWDbANz3H3pcopqCqjsdcC+QgH/9DuEXX5cFs4aBtw780N2P/t8elwsDVNmsbMbyz0OdNhzIY+JQyGgaTYcO8OgJF6LXHfoMoMU0JdZ8325by8qwO2UlXxto+vYedH2XXJqyTTIB4ubxLWRgJM70XHr3IECPbuMzSD1Sa+uTwKu3W+2NXU4tNM91ZGgEVRKhy7JGS0xawjtSHB2+AQuaThL9JrZWODuI+PrxyyrdrkhxZBbQ121oYitSt03umugHD+DPP3/IF0bJEaT87PrB7oLYEowy56ztUqKvIEoumBbmmN2XifCQ+EVCbz9H/klTKPQFwJa2PdB65g1WcojZ9NUNyJxFELioJUYQpLssD5XTT0KC/HkEieB/FaEfexxKDd2loWWysc1Mn2M92pZQ5PkGxzAHWL+H/6mAlUkG87v0VZvtAado9mR3SmjHONs5e5nYbZGlHME2WzZT0g8dGO8Y7BLOm1Frrp5LHJW7VF4zw/814b7z76+ct8+SaQ2koxfrmiMrRN8jYfjKF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfTNXWYXOvOlvPmTR9mPPGEtZ7i9THzp0XxSJV9qTwWW85UpO7Nn5RSQF41I?=
 =?us-ascii?Q?y2E0lLNRNRNgpRVcuqgmY1Ix1mpCE/dKGNWyec80AIQsnggNfaE8JePSk8OI?=
 =?us-ascii?Q?ug4Cxdem0zO4UkxYSgzSyeqmxj+w9B7rMDt6/5YaGEgF9iUBboMevcRXM4jl?=
 =?us-ascii?Q?Jc6hjFLl56fdy4FIlrJH3C9kEOONL12Alpi7g+f3Wcaa4zSBTtTY8DiBq4iW?=
 =?us-ascii?Q?3ltLx30tXeWH5gdroNkLzhoZKePsbSVPbYK1X/N4vOro8noRXOxOTOSi34oL?=
 =?us-ascii?Q?HvRMA7IXI0rORTGzW7XXJk2Vm4FmR0zm7Vd4bF98P5CYYVIr9orzdhd7LNZ5?=
 =?us-ascii?Q?g1PbBmmAHO94TivbpL5v1kzjNSpvdz5HLigxNTPxkELGTRdo3kbJ5IjFAnW2?=
 =?us-ascii?Q?FzeReHLrtMbvNFY+0a4R69OEYTUI04x82lj4TPTHD4zSgyGN2sAbjwAh0c3o?=
 =?us-ascii?Q?7wkSw+afs41QhhmIdv58q9LqxPvC/GSVpZ81DGlfPki0guR2FygozNTRg5Tn?=
 =?us-ascii?Q?G0UNQ8OdS+UDsE2ReD48Ca7UbuRu21BqOoNqiYSEyc8qu9zckYWodq5/pYy/?=
 =?us-ascii?Q?sl5B90OZ571B4J86Q0t+u0aLnefoe9+CTKTKYbYZuH4D8IbhWu/H0Vk9xtw0?=
 =?us-ascii?Q?krd8UWfmU8Zr+dAakiRFAYJ0635nTMbQ6Y00qGTVwrJz/q1KT0bB7LZU7t6/?=
 =?us-ascii?Q?33MfM9JU24DISYjFfSowobYBOSu11ZnDSr/5axEldmnVixWV2aEuP2cYZB4T?=
 =?us-ascii?Q?9ZFdhurRUv0drgQXkdRUX+xgsU1GsDeNsWWg2gyHnNhpTBX3GZYdHx9UgHyH?=
 =?us-ascii?Q?NbXWLJXkeCdyoEdSXo9dhWXWGVcK+orRGOgWOs5u+4Cbhaztbi0yzHh3BTsH?=
 =?us-ascii?Q?P3U1WMMvwLl/MJ1juFuuoWsa1hBfwlEtcjCuBcxWDE3AI2HaI5EV0xl8gRml?=
 =?us-ascii?Q?2QkqBXARfwIR48MBGj6Vs+5DL/azD6IlI1QUQKurdVlruYmTVAQp1DU17DEX?=
 =?us-ascii?Q?JSRLaAMpC22SZ9muG4kzw9NmRSt5uvKgCgFBTABq+xGJcIIOoqSDiNq8EkyO?=
 =?us-ascii?Q?AWkKARdtc+e3aU5s2auJJPG69TCmnC4PhyAn2SAjQXmKQTwASXlE2wXWCKY5?=
 =?us-ascii?Q?WAlVUARsZFrbNEjxzi93o4GRp55+IlLLrMCXIAgNGOZUslqo67cIfhkldWVh?=
 =?us-ascii?Q?bnAydMQRTgttnIFrjEscP/2+OqNoZGMZOMIZxQC7LcYJ6iRbtpDq+ZvQSAKO?=
 =?us-ascii?Q?hUv76//Nx6Vk4WrtBqlx7cwpGga1Zhpgi9g3ldX489NSce/gg/7Al0ndWapV?=
 =?us-ascii?Q?qIKk57n2GBLZDGHM3v/K3oBYYcom/N+zJbzjjJXNr4Br1BlUuEosFob+3HTk?=
 =?us-ascii?Q?trY2P2L9fCSDnBsKKChKvSa95VTTB3I8BXExN7MagimfArRZYs2WecZC0NT9?=
 =?us-ascii?Q?O7ltIvdwakkuvYDwNeeahqwDh35I6aJBRnGftYYtUHioJoa/6294UB8zowT6?=
 =?us-ascii?Q?CjSzWhgORIK4ezadUSEIFKuVOxY6NQhiU9wJbkNHyt4n1MERdPlp79cd1mKT?=
 =?us-ascii?Q?m8QZYhzzkHMN1br42zIW/a9NnJFRNSY4/aHc1DYZQD653gBtLe0qZcI5jzKi?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3hP2LNq9UU3lS1rOGNeaf7FQuVa7ToP+MYpHy2IdQj/dT75CC01gnbOciDCk?=
 =?us-ascii?Q?22TYYfj8Sbl9h+J5JwTFJQmRq22iyBGqdd/pDehHQ8MijnFTgxgfgBEqzBij?=
 =?us-ascii?Q?oXLKJYEoCfCmPQUiMIYGTJ4KVbvsiPGLGfA57lWVdSKeoEUo84Tlxh2RWWfJ?=
 =?us-ascii?Q?vPlGJD8DHhj+kHIOgYIMTdFZEYzwOQ24vwglqNenlyUC0Nvn1JBmhSjZcx8N?=
 =?us-ascii?Q?RXfWbUdVhW/yiwgl23QBfeo931t50te5bqIvHQEXATZSfso7dIaiMafWXcfy?=
 =?us-ascii?Q?odCIRHsFG0vnUptt7/N8QR0LLu+P6PCl6twOEaEYzHuME/F4kiD721+4HKqq?=
 =?us-ascii?Q?uSajsgm+vA5K7kA3/hDEurY5TNecoeofIIJSkR1w6JUJNsE8xUs3yKJFS+HY?=
 =?us-ascii?Q?PKRHxf8ttSvgqQHJiiIMjmJ02ZBKkU/GkTsnX9Zc/w91EJxYNBVlJVrusTqG?=
 =?us-ascii?Q?Sc0zmvoPnqedbzz3Gpc2gl35VuURY4svnowllr6wJron2ff8rTl6hH7B4qXK?=
 =?us-ascii?Q?TZfADP5sJgF7B6VE7aunVG2Oy5z68HQaqeXze34Qk6C9MbICHKJ1ZHy/ZH7E?=
 =?us-ascii?Q?UD3yuBojKRzWyNaVOUzzKcVvPOf0WGzYyvgTTNEK9LLwOrzmYZbSVRNour92?=
 =?us-ascii?Q?lCBS/9VM0ypjjxfeIfKNzGVbtZpfe3sMvDmZSCMiuKg7IxskV8SiQiE1w/tv?=
 =?us-ascii?Q?4ANLCKEQvZBSUo6F87CuEZA3hgPMf9o4UVbvGDzx31pfml2nim3hpF53vwTT?=
 =?us-ascii?Q?Pra+/cx3vuA9MS1O0dYdgrH9qzixeyAalOubQ6+x6eSBbNDiVSXP8yMpODhG?=
 =?us-ascii?Q?8SUx1NnHIiCqmuq3wVB9H6n7kmnjNJKiXSZsGBeiO+q3il6pcfiPMqQGeH04?=
 =?us-ascii?Q?ZjuhGelsTa1CXs5IRZ2gH6dK64WFEzRpRAQC7pJ/DCuLtB6duTBI4L1yMMS6?=
 =?us-ascii?Q?fHJC7fFDkxpWnk2oGaD762Kg50712XTDjPv5LHMxKz67uUWa2BMMIHkSpqLO?=
 =?us-ascii?Q?s74Fp+6+HjiV3F6MwQ6+0cgoNlxUb1t2ZtP+i9wZg2klS/VRgRzkOBhVac+f?=
 =?us-ascii?Q?VQKgSfDojU9qkVVJnDa7XzvTPsueQ9kHEIBUFT/RYJZO5cmoHNOw1dTGEZKu?=
 =?us-ascii?Q?RvYvZPC2ofOfmMsHcB2kLqOY/cTlMAs5I+XkLgEDHEYHVPi2jzmuSFf6V3Vx?=
 =?us-ascii?Q?tgcomY3J93sfSpixtgZIdrmZ6L5x8F6Ld7zSM4wf6/joTv3htTU2YG9psmaZ?=
 =?us-ascii?Q?uTpKYpJ7c/TjPMT+7YgLCGf922TuoJT4V69JESEBCYwjMIP70vJqp8sNYpsp?=
 =?us-ascii?Q?oi85LKCRgZ1IrPLPUGuE7Aad2w0ymebvHESBHofhj9fEEbKgOzvdzoI0Huah?=
 =?us-ascii?Q?ZUoZuZTJTU7f0nHmnA+EybM+OrEkYtKGfbsb2GCSfZkVWwfMtHoBTQOSz9Id?=
 =?us-ascii?Q?klvaC+28X/pTon4gLpyOq1OPO7RPwLGWT0Q8b3IrydUz3UtOET6+bkCewwMG?=
 =?us-ascii?Q?sxEqXuzslqbGNw3urJsTzG7Atv5Vcn11lPSTeFEbE1TpEhcVpkT1ynzUEw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30081449-50cf-4bcf-f75c-08dbdfdcbeb0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:58.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+47F0pp1dLp64/XsaXF+QGNx4uKXjCTyH50G+NXaFOhE6fFapP9FlgZWkbLue09tvBJ7p6rw4Oc1OgtLIbYhIGs3Q4Nnbi3pzbeDrnVJxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=996 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: W4-cLXilnsUSlAHwU9B3VFu0RqQKJUkU
X-Proofpoint-ORIG-GUID: W4-cLXilnsUSlAHwU9B3VFu0RqQKJUkU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e59e10f8ef63d42fbb99776a5a112841e798b3b5.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 137 +++-----------------------------------------
 1 file changed, 9 insertions(+), 128 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7ea22244c540..b8dacc7feb47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6989,156 +6989,37 @@ EXPORT_STATIC_CALL(preempt_schedule_notrace);
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
  */
-
-enum {
-	preempt_dynamic_none = 0,
-	preempt_dynamic_voluntary,
-	preempt_dynamic_full,
-};
-
-static int preempt_dynamic_mode = preempt_dynamic_full;
-
-static int sched_dynamic_mode(const char *str)
+static int __init setup_preempt_mode(char *str)
 {
-	if (!strcmp(str, "none"))
-		return 0;
-
-	if (!strcmp(str, "voluntary"))
-		return 1;
-
-	if (!strcmp(str, "full"))
-		return 2;
-
-	return -1;
-}
-
-static void sched_dynamic_update(int mode)
-{
-	/*
-	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
-	 * the ZERO state, which is invalid.
-	 */
-	static_call_update(cond_resched, __cond_resched);
-	static_call_update(might_resched, __cond_resched);
-	static_call_update(preempt_schedule, __preempt_schedule_func);
-	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-
-	switch (mode) {
-	case preempt_dynamic_none:
+	if (!strcmp(str, "none")) {
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
 		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
 		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: none\n");
-		break;
-
-	case preempt_dynamic_voluntary:
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "voluntary")) {
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, __cond_resched);
 		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
 		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
 		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: voluntary\n");
-		break;
-
-	case preempt_dynamic_full:
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "full")) {
 		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: full\n");
-		break;
-	}
-
-	preempt_dynamic_mode = mode;
-}
-
-static int __init setup_preempt_mode(char *str)
-{
-	int mode = sched_dynamic_mode(str);
-	if (mode < 0) {
-		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else {
+		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
 		return 1;
 	}
-
-	sched_dynamic_update(mode);
 	return 0;
 }
 __setup("preempt=", setup_preempt_mode);
 
-#ifdef CONFIG_SCHED_DEBUG
-
-static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
-				   size_t cnt, loff_t *ppos)
-{
-	char buf[16];
-	int mode;
-
-	if (cnt > 15)
-		cnt = 15;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-	mode = sched_dynamic_mode(strstrip(buf));
-	if (mode < 0)
-		return mode;
-
-	sched_dynamic_update(mode);
-
-	*ppos += cnt;
-
-	return cnt;
-}
-
-static int sched_dynamic_show(struct seq_file *m, void *v)
-{
-	static const char * preempt_modes[] = {
-		"none", "voluntary", "full"
-	};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, "(");
-		seq_puts(m, preempt_modes[i]);
-		if (preempt_dynamic_mode == i)
-			seq_puts(m, ")");
-
-		seq_puts(m, " ");
-	}
-
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static int sched_dynamic_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, sched_dynamic_show, NULL);
-}
-
-static const struct file_operations sched_dynamic_fops = {
-	.open		= sched_dynamic_open,
-	.write		= sched_dynamic_write,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-extern struct dentry *debugfs_sched;
-
-static __init int sched_init_debug_dynamic(void)
-{
-	debugfs_create_file("sched_preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
-	return 0;
-}
-late_initcall(sched_init_debug_dynamic);
-
-#endif /* CONFIG_SCHED_DEBUG */
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
 
-- 
2.31.1

