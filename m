Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B378A365
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjH0X02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjH0X0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:26:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2078.outbound.protection.outlook.com [40.92.40.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84777BC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9xcb1IgcpyjtKjT2xyfBtcO+AjOW0pIt095+ME/nVyrl+1PCigyTzrl5kUFhWweMHvy01a922P7zS4TkxOkaB2ZruZwXRyS8d184/pf7d7T0DsgMSrQgtPEbiByEan6IVGlXvZY1VkSv8IOd23VM1VqYnG2q1fv0EuIdzBzYXZnvP1dlXsM5t8uZqukLQ9KEgZYxBGQBKZK2YwlwAcogd93jZHadRCX/0Fu/ycsuPOCTuwX5PmC8SoUHbVtrfJHcMSYDlwQGg0Pw+k5qHzwcjbfJEKvlca1LS+DUUJ+GUkyN3Xvpcm6in1Rpse8NBGI/XGEXCA6flMi79w6JMonBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqdka8bWEbnAv27B7szEebmkrbgLt1SEVBzxCJS5ik4=;
 b=A5txSwN1ogjYsdR0dJkLkXBAG3GKRVhFzyeYrD3JrboSeUQw40yGVdiMM+FXOiFMgQxWnZQAibSqveS10qgeTkI0sGncDTg7fbK4i38Z6T7cL3JbjyRvrzRu8uo45UDD6elnE42qkLtiKoKxWeiJWon6+SGeTds1rZL5hIQyoQc/2DW6uJEFIFqYQRggWQeNljscfgOOIsI1XtAgwfHt55snNYyuekbE2sLA61c3Yz7hfJVrLEQTqHobhBTrh4linRw3w2/jvfyDb1cpmy+QNX69PlOGYhWQswoiC9pzB5EW7M37OvJVn5e6DzcymtKkRmqdGzq0SKNgYoMun51ZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqdka8bWEbnAv27B7szEebmkrbgLt1SEVBzxCJS5ik4=;
 b=b/81HrYrR4kKLVzRNe5ev73DZOScCXC1rc9SRtgS3ce77QboNMl0tZ//KHmFPUn8zvX/wLToD6Ont4MTKlNvAVeqBt+hXVGt1JREJz04CH4n8HAXAyXhpAVoVE/LiHmpB181Ix6mN+I8dJamWkOF/0fXntyz4L5wiWlCWh0c/PRXefL/0JelEVbfyYFGS9n0hQbqVPEz9olwEjo+cMve7M9oz/LuUx+DcDExWYMpJ823IMcDHyyozLX9N1Uavfkh0sdp2pCs5GCcgCCmhD8lba2keNM7iTEyBQ/dM5rV0B0pP3+o7kAbTFvBL6hrAAELcqSZDXCh6/sjecWu53lAsQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:26:08 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:26:08 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 0/6] staging: octeon: clean up octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:25:50 -0400
Message-ID: <PH7PR11MB76434DA54A9F1245AD36ABF6BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Cnw+uyUmG9VueSM6r9p/EJ1c140+jXSw8gvS4KNhQACm//+PQTSTGreDLT/LAEu4]
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <cover.1693177830.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 19eccc31-2f60-4b22-8dda-08dba754fdf5
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfkXPGeXpLbXiHv/o5cjvD/y8ykypLMiTUJxRpUhmYPebbDMecvk4M3fNvHmtAIDckF3UWl2FTPp0kUaSm0nP9gMc/aNfGdUZ8Apj+YrCHTZZoLNt8iwtWQ8NoFqZ37AhUzCmcUnluczdbNOPMAu7sKZLFV273UqiSrboXMcSollA1b1ic3gLTE6Fk9EUeeXWcOkPEqJhWQ+ZlYymZ7WEqb7Z42GnxssewIVq0TE1yPxXuk5Gn4MVpjfl6HdcfSJIBquiM3RK2fOQb+WHVoE32XdogB6OsR9iPulZVJGsBNa7aNGWfI+dkfbwahgsFc6IdVcYzDgI3vUBP2DijNXVJVw5qBzWVOXMjEmtzVU7YDRVtWCgwopUPffhvGlIylZaMeVA2c5R6ui8pmwfo2LGa7f/qYTA00fqwJ9ZVWOi/PpFkYi7hzNFYemflZ6tI3Vnf38Nc9KwUhVTkkQOoy4kly6/tW3co4+6VYGA3XRowQXuehnEdySAu3gah7hLO4+sqEwHFpn7bXFW7TMPgumWgiI3Oa0MIB+TvrskfJE2u9X6D6KG5/UH5ag1aa7AU/ZzZhZqziJ7BGFXlwePgvoD8MYnsra5ACIVD7LxV2qU8UXRT7yk9Aa/f/EKdmyD0Ue/q7us+vK/OvnnLIpR+l0cC2IFPZfx9qktMFza2LCX/OjhZO3bJOUWj8PZN3PLwxAUwrxYyrBTzbPbrvKrm476M1WI9Pt2hhYSMsXDaNFf9CN4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPtsI3cGlJkO/fnGqm+Y4oElsEWvep7D0ds7gLCUroIm0As/mBngil0rl22d7wGRXunXCKgmIa0VxtfUxponENfxJSjbJLubuV5OkPieS9EgyaEoE98OxxivndZqDggtDN9crNHAGAtS1TCgok/gT0SXxL7H67Idu6SLhcG6wd3dE/D5GRwN6Usq8HOX1wL1R4Xm1t+XPeNOIDvw7OYAuxAdvVz1ve86TSEykzLS/8CrelxC2it6hbUng59zqTC2yxQeJPGRsnp9XcMJpcMKkw2SmkwrnVnHzLb8Xq35+phnT87eaFLyR+Z9qJGJsYzpdEUdzqdQ8r7JUAZy7kZm/lNwArMwfuy9xv2WS5+VN5/mSdrerPUkI7Wjr8jPv/UczoDdoE+jV33KF0ngXfyN1/nfEMlkznWaHzvjlfpjrATqVblM7U9TtzGg7iTrdvbSGBBWp6rFXcusNJHn3kUE+/BTXvrOrTYEefpn31CLoQ0M4Gce6pMFaS1/fpl//TUC0UVcn9ibGqrbebRQmzR2QNWsnwP8hnILCeXgCJkbW55DnP8Pzt1rYlQqoW2OIoTbDrZu2Lg++FBKSAVSTfp4mpNr+Wt+aO7qPLPdhRlvJxf62koQU6kmHfPA4DGP0jfs
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDs/jplP/x17phsB5AREzORibRC3ooinXELD1oMviyVqxmKuw4l1binDc0yP?=
 =?us-ascii?Q?7lT002sA6VHmskL2UZlI8/n8jMI7R4Lmbo0oVLJAipysU1jPiVRvjETXf+XZ?=
 =?us-ascii?Q?EFo+PNPrWIzkFxzHSWKs3pbMRqbrlqPnhyCOqnVbdFWEbSpVVEmp66cubIaw?=
 =?us-ascii?Q?yKYenxXMSbQYpz25AXjnkNH38k1dJtvS7v2l3vmxiNmOo+CPtkRg9XBTaRA1?=
 =?us-ascii?Q?0UEaRjxQxK6jrTQ3mRCVZ48XgThaFE+ouiJLwmtZVtZQAO6T9fiSwEAffkPJ?=
 =?us-ascii?Q?GvYANN1pk8R9e7kN3AwzwUgh+icLacUA78w9Mt9o/rBZhi/wQD8eIczsXeYW?=
 =?us-ascii?Q?s/1EQ8bI/wx8RhoG0zA/zPiet/jQTC3YPP24uz3ZGke78zK7ApW+daPVOWcn?=
 =?us-ascii?Q?Zvs1eVTPk89qq/3YBl48ff6B/g5fj/iOg+nZBLFZecK/44sb4MR+sIlT2vZ9?=
 =?us-ascii?Q?2c52WVzVXXic4b8WVJwjmUxrv3h1IEy1zfZAtJJVfZuP+3MjL/N41ig/lJ7K?=
 =?us-ascii?Q?dZAv0Gx8KJG0SrNElbSPEAnH720C3jldr+nvb9pMgNY7eWzHlzQaSjo8/+4a?=
 =?us-ascii?Q?zatwPucJZ4fRylYJ2kjvaLL3Lmsn/NeGsgBvY1qn7Y7wlGgYBxLVYQAvrrDi?=
 =?us-ascii?Q?ONwSs+ffTiLG677VSTwfbpRbf0douKiuGQHhYRGThOrch2NSusprh+uRLcAR?=
 =?us-ascii?Q?dNcDYgmDyaE5Ozf8Q4BP9P6NlHULPKtkG3LEVJP8e9Geng1YEi3AktWBo6gA?=
 =?us-ascii?Q?/teIw/4D1WmZWLnbiOaib39DMJoGUZ5wGogs6xH2l9sfThvfKNW3Pqa1G3UG?=
 =?us-ascii?Q?CigOSS+C96fDm07feGk6ANQC9arrYP/ycU06wI7seZAH1X5cT4+TciizmxL0?=
 =?us-ascii?Q?1ZsVtG0iyrNhHaulUC+7XCeUInaZSDjWHl5+6JGvJoZaG9jeV0/pgTnXlmdV?=
 =?us-ascii?Q?d4cCOUAK8A5jRHJq1kaxUmL7+IgRWDuG/Na7yUE3qWG2A0CP0mafmGsn0aQl?=
 =?us-ascii?Q?kVCI3SQb30bKIWTgHpPFvp+A5fA7YX+b4ZrBCxdJLGnRC+fdpihB6RQKgX/t?=
 =?us-ascii?Q?5khO9HZai50rnCKZPJ8x9QVjhsrOnwtfjyXiaxf5RN0TOG+hPIG/jhyuoKx4?=
 =?us-ascii?Q?RCG3o0lJ/WRn19OtP7kc/gEzr2jH1f11+XBYrI8dq+UYvHYs4zIoj4ZBGhxh?=
 =?us-ascii?Q?e0P6pqERu9d95ngJ3n7GEDF8XXn9tBtuXJJhXazYARQooRxjW0IrNl/+Rwwv?=
 =?us-ascii?Q?XaMFowB8uW4Cm1F/0urX/qlzOXboV0o8eftQwYgoIA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eccc31-2f60-4b22-8dda-08dba754fdf5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:26:08.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standards

Oliver Crumrine (6):
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver

 drivers/staging/octeon/ethernet.c     |  4 +--
 drivers/staging/octeon/octeon-stubs.h | 44 +++++++++++++--------------
 2 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.39.3

